{ config, lib, ... }:

{
    boot = lib.mkIf (config.wsl.enable == false) {
        consoleLogLevel = 3;
        initrd.verbose = true;
        
        loader = {
            efi.canTouchEfiVariables = true;
            systemd-boot.enable = true;
        };
    };
}
