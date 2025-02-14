{ config, ... }:

{
    boot = {
        kernel.sysctl = {
            "net.ipv4.ip_forward" = 1;
            "vm.swappiness" = 60;
        };
        kernelParams = [
            "elevator=bfq"
            "tsc=directsync"
        ];
        loader = {
            efi.canTouchEfiVariables = true;
            systemd-boot.enable = true;
        };
    };
}
