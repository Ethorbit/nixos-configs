{ config, pkgs, ... }:

let
    flatpakCommand = pkgs.writeShellScript "command.sh" ''
        obs --startreplaybuffer --minimize-to-tray
    '';

    desktopScript = pkgs.writeShellScript "script.sh" ''
        flatpak run --command="${flatpakCommand.outPath}" com.obsproject.Studio
    '';
in
{
    # This will make sure OBS starts in the background with Replay ON
    home-manager.sharedModules = [ {
        xdg.desktopEntries = {
            "com.obsproject.Studio2" = {
                name = "OBS Studio (Custom)";
                icon = "com.obsproject.Studio";
                genericName = "Streaming/Recording Software";
                exec = desktopScript.outPath;
                categories = [
                    "AudioVideo"
                    "Recorder"
                ];
                startupNotify = true;
            };
        };
        # LOL if you want to actually hide the original desktop entry, it cannot be done declaratively..
        # So to avoid original OBS from appearing on top, you have to imperatively create the desktop entry in your home,
        # hide it with NoDisplay=true so that this custom entry is the only one that shows.
        #home.file."~/.local/share/applications/com.obsproject.Studio.desktop".source = desktopFile;
    } ];

    services.flatpak = {
        enable = true;
        packages = [
            {
                appId = "com.obsproject.Studio";
                origin = "flathub";
            }
            {
                appId = "com.obsproject.Studio.Plugin.OBSVkCapture";
                origin = "flathub";
            }
            {
                appId = "org.freedesktop.Platform.VulkanLayer.OBSVkCapture/x86_64/24.08";
                origin = "flathub";
            }
        ];
    };
}
