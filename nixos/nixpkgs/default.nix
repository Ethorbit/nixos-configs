{ inputs, system, lib, config, ... }:

{
    nixpkgs = {
        # So if your container is reporting an error in this file,
        # make sure it has boot.isContainer = true;
        # because nix is stupid and won't give us access
        # to the system attribute if the file is loaded by 
        # a container for whatever reason...
        hostPlatform = lib.mkIf (config.boot.isContainer == false) (lib.mkForce system);

        config = {
           allowUnfree = true;
           chromium = {
                enableWideVine = true;
           };
        };
    };
}
