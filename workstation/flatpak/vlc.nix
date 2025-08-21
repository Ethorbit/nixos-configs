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
                    # no more network sharing
                    share = [
                        "ipc"
                    ];
                };
                "Session Bus Policy" = {
                    "org.freedesktop.secrets" = "none";
                };
            };
        };
    };
}
