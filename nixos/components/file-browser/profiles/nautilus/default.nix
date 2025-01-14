{ config, pkgs, ... }:

with pkgs;
{
    imports = [
        ./gst-fix.nix
    ];

    environment.systemPackages = [
        gnome.nautilus
    ];

    #If GVfs is not available, you may see errors such as "Sorry, could not display all the contents of “trash:///”: Operation not supported" when trying to open the trash folder, or be unable to access network filesystems. 
    services.gvfs.enable = true;
}
