{ config, pkgs, lib, system, inputs, ... }:

let
    name = "steam";
    debug = true;

    # Currently there's no way to control which socket gamescope creates
    # We'd have to patch it and add a --nested-display
    # For now, we'll assume gamescope is :1 :(
    gamescopeDisplay = 1;

    commands = {
        link = "sudo ip link delete vb-steam";
        stop = "sudo nixos-container stop ${name}";
        start = "sudo nixos-container start ${name}";
        run = c: "sudo nixos-container run ${name} -- su steam -c 'cd ~/ && ${c}'";
    };
in
{
    # Since we only run the wrapper when :1 doesn't exist, we can make the script empty
    ethorbit.components.gaming.dependencies.gamescope.wrappers."steam".script
    = lib.mkForce (pkgs.writeShellScript "script" ''
        ${commands.link} 2> /dev/null
        ${commands.stop} 2> /dev/null
        ${commands.start}
        ${commands.run "steam-acolyte"}
    '');

    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.packages = [
            (pkgs.writeShellScriptBin "container-steam" ''
                ${config.ethorbit.components.gaming.dependencies.gamescope.wrappers."steam".wrapper}
            '')
        ];

        xdg.desktopEntries = let
            desktopShared = {
                genericName = "Steam Container";
                icon = "steam";
                terminal = true; # Keep true to see the sudo prompt, or use NOPASSWD in sudoers
                categories = [ "Game" ];
                comment = "Launches Steam inside the 'steam' container using the su-login method.";
            };
        in {
            "steam-nspawn" = desktopShared // {
                name = "Steam (Nspawn)";
                exec = "container-steam";
            };
        };
    };

    containers."${name}" = let
        devices = [
            #"/dev/shm"
            "/dev/dri"
            "/dev/nvidia0"
            "/dev/nvidia-modeset"
            "/dev/nvidiactl"
            "/dev/nvidia-uvm"
            "/dev/nvidia-uvm-tools"
            "/dev/nvidia-caps"
        ];
    in {
        # This is needed or else a container process
        # can access the host's X display through
        # the network! (ss -xl | grep X11)
        privateNetwork = true;
        hostBridge = "br0";

        bindMounts = {
            "/home/steam/.Xauthority" = {
              hostPath = "/home/workstation/.Xauthority";
              isReadOnly = true;
            };

            # Only give it access to gamescope's X socket
            "/tmp/.X11-unix/X${toString gamescopeDisplay}" = {
                hostPath = "/tmp/.X11-unix/X${toString gamescopeDisplay}";
                isReadOnly = true;
            };

            "/mnt/games" = {
                hostPath = "/mnt/games/Steam";
                isReadOnly = false;
            };
        } // lib.genAttrs devices (d: {
            hostPath = d;
            isReadOnly = false;
        });

        allowedDevices = map (d: {
            modifier = "drm";
            node = d;
        }) devices;

        specialArgs = {
            inherit inputs system lib;
            homeModules = inputs.ethorbit-home.homeModules.${system};
        };

        config = { config, pkgs, ... }: let
            username = "${name}";
            uid = config.users.users."${config.ethorbit.users.primary.username}".uid;
        in {
            imports = [
                inputs.home-manager.nixosModules.default

                (import ../../../nixosmodules.nix {
                    inherit inputs system lib;
                })

                ../../../nixos/components/display-server/profiles/xserver
                ../../../nixos/components/gaming/steam/profiles/native
                ../../graphics.nix
            ];

            # Network
            networking = {
                useHostResolvConf = false;
                useNetworkd = true;
                useDHCP = false;
                defaultGateway = lib.mkForce {
                    address = "172.16.1.1";
                    interface = "eth0";
                };
            };

            systemd.network.networks."40-eth0" = {
                matchConfig.Name = "eth0";
                address = [ "172.16.1.211/24" ];
                gateway = [ config.networking.defaultGateway.address ];
                dns = [ config.networking.defaultGateway.address ];
                linkConfig.RequiredForOnline = "no";
            };

            # User
            ethorbit.users.primary.username = username;
            users = {
                allowNoPasswordLogin = true;
                users."${username}" = {
                    linger = true;
                    extraGroups = [ "video" "input" "audio" ];
                };
            };

            environment = {
                sessionVariables = {
                    DISPLAY = ":1";
                    XDG_RUNTIME_DIR = "/run/user/${toString uid}";
                    DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/${toString uid}/bus";
                    XAUTHORITY = "/home/${username}/.Xauthority";
                };

                systemPackages = with pkgs; [
                ] ++ (if debug then [
                    xorg.xwininfo
                ] else []);
            };

            services.getty.autologinUser = username;
        };
    };
}
