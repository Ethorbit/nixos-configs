{ config, ... }:

let
     cfg = config.ethorbit.components.recording.obs.flatpak;
in
{
    imports = [
        ../../.
        ./options.nix
        ./home-manager.nix
    ];

    services.flatpak = {
         enable = true;
         packages = [
             {
                 appId = "${cfg.appIds.obs}";
                 origin = "flathub";
             }
             {
                 appId = "${cfg.appIds.obsVkCapture}";
                 origin = "flathub";
             }
             {
                 appId = "${cfg.appIds.obsVkCapturePlugin}";
                 origin = "flathub";
             }
         ];
         overrides = {
            "${cfg.appIds.obs}" = {
                "Context" = {
                    filesystems = [ "/var/lib/flatpak/runtime/com.obsproject.Studio.Plugin.PulseAudioAppCapture:ro" ];
                };
            };
         };
     };
}
