{ config, lib, pkgs, ... }:

with pkgs;
with lib;

{
    imports = [
        ./gst-fix.nix
    ];

    environment.systemPackages = let
        oldVersion = (
            builtins.compareVersions 
                config.system.nixos.release "25.05" 
                == -1
        );
    in with pkgs; [
        # gnome.nautilus moved to top-level
        (mkIf (oldVersion) gnome.nautilus)
        (mkIf (!oldVersion) nautilus)
    ];

    #If GVfs is not available, you may see errors such as "Sorry, could not display all the contents of “trash:///”: Operation not supported" when trying to open the trash folder, or be unable to access network filesystems. 
    services.gvfs.enable = true;
}
