{ config, lib, ... }:

{
    boot = lib.mkIf (config.ethorbit.system.container == "") {
        consoleLogLevel = 3;
        initrd.verbose = true;
        
        loader = {
            efi.canTouchEfiVariables = true;
            systemd-boot.enable = true;
        };
    };
}
