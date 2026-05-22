{ config, lib, ... }:

# Gmod cluster
let
    cfg = config.ethorbit.nzc;

    ftpPort = 40000;

    count = 1;

    initialPorts = {
        query = 27020;
        client = 27120;
    };
    initialPort = 27020;
    group = rec {
        assignment = {
            alpha = [ ];
            bravo = [ 1 ];
        };

        get = number:
            lib.findFirst
                (group: builtins.elem number assignment.${group})
                (throw "no group for server ${toString number}")
                (builtins.attrNames assignment);
    };

    user = {
        uid = 2000;
        gid = 2000;
    };

    ips = {
        eth = cfg.network.ethernet.ip;
        vpn = cfg.network.vpn.ip.private.address;
    };

    disk.device = cfg.nix-docker.disk.primary;
    cpu = cfg.nix-docker.cpu;

    gmods = (
        builtins.listToAttrs (
            builtins.genList (i: let
                serverNumber = i + 1;
                portNumbers = {
                    query = initialPorts.query + i;
                    client = initialPorts.client + i;
                };
                name = "gmod_${toString serverNumber}";
            in {
                inherit name;
                value = {
                    project = "gameserver/gmod";
                    instance = {
                        inherit user;
                        limit = {
                            enable = true;
                            cpu = {
                                # Gmod is singlethreaded:
                                threads = [
                                    (cpu.threadOf cpu.threads.game i)
                                ];
                                weight = 1024;
                            };
                            memory = 1500;
                            bandwidth = 10;
                            disk = [
                                {
                                    inherit (disk) device;
                                    read = {
                                        speed = 120;
                                        iops = 10000;
                                    };
                                    write = {
                                        speed = 60;
                                        iops = 5000;
                                    };
                                }
                            ];
                        };
                        storage.volumes = {
                            gmod = {
                                volume = name;
                                scope = "global"; 
                            };
                            shared = {
                                volume = "gmod_${group.get serverNumber}_shared";
                                scope = "global";
                            };
                        };
                        network.ports = {
                            query = {
                                number = portNumbers.query;
                                # Don't expose RCON
                                ip = {
                                    udp = ips.vpn;
                                    tcp = "127.0.0.1";
                                };
                            };

                            client = {
                                number = portNumbers.client;
                                ip.udp = ips.vpn;
                            };
                        };
                        secrets = {
                            "password.rcon" = config.age.secrets."nzc-nix-docker/gmod/rcon_password".path;
                            "token.steam" = config.age.secrets."nzc-nix-docker/gmod/${toString serverNumber}/token".path;
                        };
                    };
                };
            }) count
        )
    );
in {
    assertions = [
        {
            assertion = builtins.all
            (n: builtins.any
                (numbers: builtins.elem n numbers)
                (builtins.attrValues group.assignment)
            )
            (lib.range 1 count);
            message = "Not all gmod servers have a group assigned";
        }
        {
            assertion =
                let numbers = builtins.concatLists (builtins.attrValues group.assignment);
                in builtins.length numbers == builtins.length (lib.unique numbers);
            message = "Duplicate server numbers found in group assignment";
        }
    ];

    age.secrets = (
        lib.genAttrs
            (map
                (n: "nzc-nix-docker/gmod/${toString n}/token")
                (lib.range 1 count)
            )
            (name: {
                file = ../../secrets/${name}.age;
                owner = toString user.uid;
                group = toString user.gid;
            })
    ) // {
        "nzc-nix-docker/gmod/rcon_password" = {
            file = ../../secrets/nzc-nix-docker/gmod/rcon_password.age;
            owner = toString user.uid;
            group = toString user.gid;
        };

        "nzc-nix-docker/gmod/sftp_password" = {
            file = ../../secrets/nzc-nix-docker/gmod/sftp_password.age;
            owner = toString user.uid;
            group = toString user.gid;
        };
    };

    nzc.instances = gmods 
    // # Remotely manage files
    {
        gmod_sftp = {
            project = "sftp";
            instance = {
                inherit user;
                network.ports.sftp = {
                    number = ftpPort;
                    ip.tcp = "${ips.eth}";
                };
                limit = {
                    enable = true;
                    cpu = {
                        # 5% CPU utilization allowed
                        threads = cpu.threads.all;
                        quota = 0.6;
                        # 75% less CPU time than gmod
                        weight = 256;
                    };
                    memory = 512;
                    bandwidth = 20;
                    disk = [
                        {
                            inherit (disk) device;
                            read = {
                                speed = 160;
                                iops = 20000;
                            };
                            write = {
                                speed = 80;
                                iops = 15000;
                            };
                        }
                    ];
                };
                storage.volumes = builtins.listToAttrs (
                    # individual server
                    (map (n: let
                        groupName = group.get n;
                        volume = "gmod_${toString n}";
                    in {
                        name = "${volume}_${groupName}";
                        value = {
                            volume = volume;
                            scope = "global";
                        };
                    }) (lib.range 1 count))
                    ++
                    # shared storage
                    (map (groupName: {
                        name = "gmod_shared_${groupName}";
                        value = {
                            volume = "gmod_${groupName}_shared";
                            scope = "global";
                        };
                    }) (builtins.attrNames group.assignment))
                );
                secrets = {
                    "password" = config.age.secrets."nzc-nix-docker/gmod/sftp_password".path;
                    # ethorbit
                    "sftp.public.key" = builtins.toFile "key" ''
                    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/m67X4bZrhN86eFAAp3RGEzhzUp0k1WAP7dw31fAVS ethorbit@nixos
                    '';
                    # backups
                    "ssh.public.key" = builtins.toFile "key" ''
                    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPxiv+/P62qflc3e03W8EOdeXqV7wIQxGUU52zbJO28V workstation@workstation
                    '';
                };
            };
        };
    };
}
