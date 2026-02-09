{ config, pkgs, lib, system, inputs, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.packages = let
            command = c: "sudo nixos-container run steam -- su steam -c 'cd ~/ && ${c}'";
        in [
            (pkgs.writeShellScriptBin "container-steam-gamescope" ''
                ${command "steam-acolyte-gamescope"}
            '')
            (pkgs.writeShellScriptBin "container-steam" ''
                ${command "steam-acolyte"}
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
            "steam-gamescope-nspawn" = desktopShared // {
                name = "Steam - Gamescope (Nspawn)";
                exec = "container-steam-gamescope";
            };

            "steam-nspawn" = desktopShared // {
                name = "Steam (Nspawn)";
                exec = "container-steam";
            };
        };
    };

    containers.steam = let
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

            "/tmp/.X11-unix" = {
                hostPath = "/tmp/.X11-unix";
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
            username = "steam";
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

            # Make gaming steam's gamescope wrapper run steam-acolyte
            ethorbit.components.gaming.dependencies.gamescope.wrappers."steam".script 
            = pkgs.writeShellScript "script" ''
                steam-acolyte
            '';
            # Make a script called steam-acolyte-gamescope that runs the gamescope wrapper we defined above
            home-manager.users.${config.ethorbit.users.primary.username} = {
                home.packages = [
                    (pkgs.writeShellScriptBin "steam-acolyte-gamescope" ''
                        exec "${config.ethorbit.components.gaming.dependencies.gamescope.wrappers."steam".wrapper}"
                    '')
                ];
            };
        };
    };
}
