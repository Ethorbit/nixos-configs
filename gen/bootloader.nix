{ ... }:

{
    boot = {
        kernelParams = [
            "processor.max_cstate=1"
            "idle=nomwait"
        ];

        kernel.sysctl = {
            "vm.swappiness" = 10;
        };

        loader = {
            efi.canTouchEfiVariables = true;
            systemd-boot.enable = true;
        };
    };
}
