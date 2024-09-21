{ config, pkgs, ... }:

with pkgs;
{
    environment.systemPackages = [
        gnome.nautilus
    ];

    #If GVfs is not available, you may see errors such as "Sorry, could not display all the contents of “trash:///”: Operation not supported" when trying to open the trash folder, or be unable to access network filesystems. 
    services.gvfs.enable = true;

    #Unless you've installed Gstreamer plugins system-wide, the "Audio and Video Properties" pane under the "Properties" menu for media files will say "Oops! Something went wrong. Your GStreamer installation is missing a plug-in."

    #To enable the A/V Properties and see details like media length, codec, etc, the following overlay may be used: 
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
}
