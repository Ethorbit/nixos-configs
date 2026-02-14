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
                terminal = false;
                categories = [ "Game" ];
                comment = "Launches Steam inside the 'steam' container using the su-login method.";
            };
        in {
            "steam-nspawn" = desktopShared // {
                name = "Steam (Nspawn)";
                exec = "${pkgs.kitty}/bin/kitty container-steam";
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

        bindMounts = let
            # idmap hack since it's not supported by NixOS container module
            # https://github.com/NixOS/nixpkgs/issues/419007#issuecomment-2994320632
            # https://github.com/NixOS/nixpkgs/issues/329530#issuecomment-2513815925
            idmap = s: "${s}:idmap";
        in {
            # Only give it access to gamescope's X socket
            "/tmp/.X11-unix/X${toString cfg.gamescope.display}" = {
                mountPoint = idmap "/tmp/.X11-unix/X${toString cfg.gamescope.display}";
                hostPath = "/tmp/.X11-unix/X${toString cfg.gamescope.display}";
                isReadOnly = true;
            };

            # Not compatible with privateUsers "pick"
            # For now, our solution is to allow any local
            # user to snoop on us. We're just Steam afterall
            # "/home/steam/.Xauthority" = {
            #     mountPoint = idmap "/home/steam/.Xauthority";
            #     hostPath = "/home/workstation/.Xauthority";
            #     isReadOnly = true;
            # };

            # Steam Client
            "/home/${toString cfg.username}/.local/share/Steam" = {
                mountPoint = idmap "/home/${toString cfg.username}/.local/share/Steam";
                hostPath = "/mnt/games/Steam/.steam";
                isReadOnly = false;
            };

            # Steam Games
            "/mnt/games" = {
                mountPoint = idmap "/mnt/games";
                hostPath = "/mnt/games/Steam";
                isReadOnly = false;
            };

            # Share audio with host
            # (TODO: figure out how to isolate a container's audio safely)
            "/home/${cfg.username}/.pulse" = {
                mountPoint = idmap "/home/${cfg.username}/.pulse";
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
                ../../graphics.nix
                ../../../nixos/components/gaming/steam/profiles/native
                ../../../nixos/components/display-server/profiles/xserver
                ../../../nixos/components/audio-server/profiles/pulseaudio
                # Since passing XDG grants privileges over host, we need
                # our own toolset for accessing and viewing our files
                ../../../nixos/components/window-manager
                ../../../nixos/components/programming/ide
                ../../../nixos/components/file-browser/profiles/nautilus
            ];
        };
    };
}
