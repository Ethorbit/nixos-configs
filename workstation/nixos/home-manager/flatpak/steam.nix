{ config, ... }:

let
    id = "com.valvesoftware.Steam";
in
{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        services.flatpak = {
            packages = [
                { appId = "${id}"; origin = "flathub"; }
                {
                    appId = "com.valvesoftware.Steam.CompatibilityTool.Proton-GE";
                    # Bump SDK to 23.08 (185907be). Downgrades 9.15 to 8.14,
                    # but also fixes stability issues with 23.08 gamescope
                    # crashing for games
                    commit = "26d25975ae67c5db7d0e5973ccc8a1ca6bd75af8aa2f6ee5d57fe7ae76ef317e";
                    origin = "flathub";
                }
                {
                    appId = "runtime/org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08";
                    origin = "flathub";
                }
                {
                    appId = "runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08";
                    origin = "flathub";
                }
            ];
            overrides = {
                "${id}".Context = {
                    filesystems = config.ethorbit.workstation.home-manager.flatpak.overrides.games.filesystems;
                };
            };
        };

        home.file.".config/systemd/user/app-flatpak-${id}-.scope.d/slice.conf".text = ''
            [Scope]
            Slice=gaming.slice
        '';
    };
}
