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
        DISPLAY=:${toString cfg.gamescope.display} xhost +local:
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
        privateUsers = "pick";

        # Or else a container process
        # can access the host's X display through
        # the network! (ss -xl | grep X11)
        privateNetwork = true;
        hostBridge = "br0";

        bindMounts = {
            # idmap hack since it's not supported by NixOS container module
            # https://github.com/NixOS/nixpkgs/issues/419007#issuecomment-2994320632
            # https://github.com/NixOS/nixpkgs/issues/329530#issuecomment-2513815925

            # Only give it access to gamescope's X socket
            "/tmp/.X11-unix/X${toString cfg.gamescope.display}" = {
                mountPoint = "/tmp/.X11-unix/X${toString cfg.gamescope.display}:idmap";
                hostPath = "/tmp/.X11-unix/X${toString cfg.gamescope.display}";
                isReadOnly = true;
            };

            # Not compatible with privateUsers "pick"
            # For now, our solution is to allow any local
            # user to snoop on us. We're just Steam afterall
            # "/home/steam/.Xauthority" = {
            #     mountPoint = "/home/steam/.Xauthority:idmap";
            #     hostPath = "/home/workstation/.Xauthority";
            #     isReadOnly = true;
            # };

            "/mnt/games" = {
                mountPoint = "/mnt/games:idmap";
                hostPath = "/mnt/games/Steam";
                isReadOnly = false;
            };

            "/home/${cfg.username}/.pulse" = {
                mountPoint = "/home/${cfg.username}/.pulse:idmap";
                hostPath = "/tmp/pulse";
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
                ../../../nixos/components/audio-server/profiles/pulseaudio
                ../../../nixos/components/gaming/steam/profiles/native
                ../../graphics.nix
            ];
        };
    };
}
