{ config, pkgs, lib, ... }:

with lib;

let
    cfg = config.ethorbit.components.recording.obs;
    desktopScript = pkgs.writeShellScript "script.sh" ''
        ${cfg.command}
    '';
in
{
     #home.file."~/.local/share/applications/com.obsproject.Studio.desktop".source = this_does_not_do_anything;
     # If you want to actually hide the original OBS desktop entry, it cannot be done declaratively..
     #
     # So to avoid original OBS from appearing on top in the app launcher, you have to imperatively
     # create the desktop entry in your home, and hide it with NoDisplay=true

     home-manager.sharedModules = [ {
         xdg.desktopEntries = {
             "com.obsproject.Studio2" = {
                 name = "OBS Studio (Custom)";
                 icon = ""; # TODO: actually set this..
                 genericName = "Streaming/Recording Software";
                 exec = desktopScript.outPath;
                 categories = [
                     "AudioVideo"
                     "Recorder"
                 ];
                 startupNotify = true;
             };
         };
     } ];
}
