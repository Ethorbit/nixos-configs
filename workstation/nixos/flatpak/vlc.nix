{ config, ... }:

let
    id = "org.videolan.VLC";
in
{
    services.flatpak = {
        enable = true;

        packages = [
            {
                appId = "${id}";
                origin = "flathub";
            }
        ];
        # Hardening
        overrides = {
            "${id}" = {
                "Context" = {
                    share = [
                        "ipc"
                        # no more network sharing
                    ];
                };
                "Session Bus Policy" = {
                    "org.freedesktop.secrets" = "none";
                };
            };
        };
    };
}
