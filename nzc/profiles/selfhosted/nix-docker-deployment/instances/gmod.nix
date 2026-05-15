{ config, ... }:

let
    ips = {
        eth = config.ethorbit.nzc.network.ethernet.ip;
        vpn = config.ethorbit.nzc.network.vpn.ip.private;
    };
    count = 1;
    initialPort = 27020;
    ftpPort = 40000;
    user = {
        uid = 2000;
        gid = 2000;
    };

    gmods = (
        builtins.listToAttrs (
            builtins.genList (i: let
                serverNumber = i + 1;
                portNumber = initialPort + i;
                name = "gmod_${toString serverNumber}";
            in {
                inherit name;
                value = {
                    project = "gameserver/gmod";
                    instance = {
                        inherit user;
                        storage.volumes = {
                            gmod = {
                                volume = name;
                                scope = "global"; 
                            };
                            shared = {
                                volume = "gmod_shared";
                                scope = "global";
                            };
                        };
                        network.ports.gmod = {
                            number = portNumber;
                            # Don't expose RCON
                            ip = {
                                udp = ips.vpn;
                                tcp = "127.0.0.1";
                            };
                        };
                        secrets = {
                            "password.rcon" = config.age.secrets."nzc-nix-docker/gmod/rcon_password".path;
                        };
                    };
                };
            }) count
        )
    );
in {
    age.secrets."nzc-nix-docker/gmod/rcon_password" = {
        file = ../../secrets/nzc-nix-docker/gmod/rcon_password.age;
        owner = "nzc";
    };

    age.secrets."nzc-nix-docker/gmod/sftp_password" = {
        file = ../../secrets/nzc-nix-docker/gmod/sftp_password.age;
        owner = "nzc";
    };

    # Gmod cluster
    nzc.instances = gmods 
    // # Remotely manage its files
    {
        gmod_sftp = {
            project = "sftp";
            instance = {
                inherit user;
                network.ports.sftp = {
                    number = ftpPort;
                    ip.tcp = "${ips.eth}";
                };
                storage.volumes = builtins.listToAttrs (
                    builtins.concatLists (
                        builtins.map (v:
                            builtins.map (vol: {
                                name = vol.volume;
                                value = {
                                    volume = vol.volume;
                                    scope = "global";
                                };
                            }) (builtins.attrValues v.instance.storage.volumes)
                        ) (builtins.attrValues gmods)
                    )
                );
                secrets = {
                    "password" = config.age.secrets."nzc-nix-docker/gmod/sftp_password".path;
                    # ethorbit
                    "sftp.public.key" = builtins.toFile "key" ''
                    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/m67X4bZrhN86eFAAp3RGEzhzUp0k1WAP7dw31fAVS ethorbit@nixos
                    '';
                    # nixos
                    "ssh.public.key" = builtins.toFile "key" ''
                    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIMGNAhCknWm5sYlpao654MffJx4I6HNlZhocSatNrss ethorbit@space
                    '';
                };
            };
        };
    };
}
