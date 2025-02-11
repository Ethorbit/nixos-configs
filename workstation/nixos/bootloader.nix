{ config, lib, ... }:

{
    boot = {
        kernelParams = [
            "processor.max_cstate=1"
            "idle=nomwait"
        ];
        loader = {
            efi.canTouchEfiVariables = true;
            systemd-boot.enable = true;
        };
    };
}
