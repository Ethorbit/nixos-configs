{ config, pkgs, ... }:

let
    cfg = config.ethorbit.components.gaming.minecraft.launcher.flatpak;
    id = cfg.appName;
in
{
    ethorbit.components.gaming.minecraft.launcher.flatpak.gamescope = {
        enable = true;
        # For OBS capture support
        # (https://github.com/nowrep/obs-vkcapture/issues/228)
        scripts.normal = pkgs.writeShellScript "script" ''
            ${cfg.gamescope.commands.gamemode} \
                flatpak run --branch=stable --arch=x86_64 --env=DISPLAY="$GAMESCOPE_DISPLAY" \
                  --command=sh org.prismlauncher.PrismLauncher -c '/usr/lib/extensions/vulkan/OBSVkCapture/bin/obs-gamecapture prismlauncher' \
                  ${id}
        '';
    };

    home-manager.users.${config.ethorbit.users.primary.username} = {
        services.flatpak = {
            overrides = {
                "${id}" = {
                    Context = {
                        filesystems = [ "/mnt/games/PrismLauncher" ];

                        # It can still do inter-process communication with its own container processes.
                        # There's really no need for it to need this for my use case
                        shared = "!ipc";
                    };
                };
            };
        };

        home.file = {
            ".config/systemd/user/app-flatpak-${id}-.scope.d/slice.conf".text = ''
                [Scope]
                Slice=gaming.slice
            '';
        };
    };
}
