{ config, pkgs, lib, system, inputs, ... }:

with lib;

let
    cfg = config.ethorbit.workstation.container.steam;
    name = cfg.name;
    commands = cfg.commands;
in
{
    imports = [
        ./options.nix
    ];

    ethorbit.components.gaming.dependencies.gamescope.wrappers."steam".script
    = mkForce (pkgs.writeShellScript "script" ''
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
            "/tmp/.X11-unix/X${toString cfg.gamescope.display}" = {
                hostPath = "/tmp/.X11-unix/X${toString cfg.gamescope.display}";
                isReadOnly = true;
            };

            "/mnt/games" = {
                hostPath = "/mnt/games/Steam";
                isReadOnly = false;
            };
        } // genAttrs devices (d: {
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

        config = { config, pkgs, ... }: {
            imports = [
                inputs.home-manager.nixosModules.default

                (import ../../../nixosmodules.nix {
                    inherit inputs system lib;
                })

                ./options.nix
                ./config
                ../../../nixos/components/display-server/profiles/xserver
                ../../../nixos/components/gaming/steam/profiles/native
                ../../graphics.nix
            ];
        };
    };
}
