{ config, pkgs, lib, ... }:

with pkgs;
with lib;

let
    older-than-24-11 = (
        builtins.compareVersions 
            config.system.nixos.release "24.11" == -1
    );
in

{
    #Unless you've installed Gstreamer plugins system-wide, the "Audio and Video Properties" pane under the "Properties" menu for media files will say "Oops! Something went wrong. Your GStreamer installation is missing a plug-in."

    #To enable the A/V Properties and see details like media length, codec, etc, the following overlay may be used: 
    config = mkIf (older-than-24-11) {
        nixpkgs.overlays = [(self: super: {
          gnome = super.gnome.overrideScope' (gself: gsuper: {
            nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
              buildInputs = nsuper.buildInputs ++ (with gst_all_1; [
                gst-plugins-good
                gst-plugins-bad
              ]);
            });
          });
        })];
    };
}
