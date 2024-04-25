
{ config, lib, ... }:

{
    boot = {
        consoleLogLevel = 3;
        initrd.verbose = true;
        
        loader = {
            efi.canTouchEfiVariables = true;
            systemd-boot.enable = true;
        };
    };
}
