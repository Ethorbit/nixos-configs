{ config, pkgs, lib, system, inputs, ... }:

let
    name = "steam";

    # Currently there's no way to control which socket gamescope creates
    # We'd have to patch it and add a --nested-display
    # For now, we'll assume gamescope is :1 :(
    gamescopeDisplay = 1;

    start = {
        command = "sudo nixos-container start ${name}";
        time = 5; # estimation of how long it takes to be ready \o/
    };

    run = c: "sudo nixos-container run ${name} -- su steam -c 'cd ~/ && ${c}'";
in
{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.packages = [
            (pkgs.writeShellScriptBin "container-steam" ''
                add_delay=0

                if [ ! -f "/tmp/.X11-unix/X1" ]; then
                    ${config.ethorbit.components.gaming.dependencies.gamescope.wrappers."steam".wrapper}
                    add_delay=1
                fi

                if nixos-container status steam | grep -q 'down'; then
                    ${start.command}
                    add_delay=1
                fi

                if [ $add_delay -eq 1 ]; then
                    sleep ${toString start.time}
                fi

                ${run "steam-acolyte"}
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
            "/dev/shm"
            "/dev/dri"
            "/dev/nvidia0"
            "/dev/nvidia-modeset"
            "/dev/nvidiactl"
            "/dev/nvidia-uvm"
            "/dev/nvidia-uvm-tools"
            "/dev/nvidia-caps"
        ];
    in {
        bindMounts = {
            "/home/steam/.Xauthority" = {
              hostPath = "/home/workstation/.Xauthority";
              isReadOnly = true;
            };

            "/tmp/.X11-unix/X0" = {
                # Only give it access to gamescope's X socket
                hostPath = "/tmp/.X11-unix/X${toString gamescopeDisplay}";
                isReadOnly = false;
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

                ../../../nixos/components/gaming/${username}/profiles/native
                ../../graphics.nix
            ];

            ethorbit.users.primary.username = "${username}";
            users = {
                allowNoPasswordLogin = true;
                users."${username}" = {
                    linger = true;
                    extraGroups = [ "video" "input" "audio" ];
                };
            };

            environment.sessionVariables = {
                DISPLAY = ":0";
                XDG_RUNTIME_DIR = "/run/user/${toString uid}";
                DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/${toString uid}/bus";
                XAUTHORITY = "/home/${username}/.Xauthority";
            };

            services.getty.autologinUser = username;
        };
    };
}
