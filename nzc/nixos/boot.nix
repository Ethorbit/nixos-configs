{
    boot = {
        consoleLogLevel = 3;
        initrd.verbose = true;
        
        kernel.sysctl = {
            "net.ipv4.ip_forward" = 1;
            "net.ipv6.conf.eth0.disable_ipv6" = true;
        };
        
        loader = {
            efi.canTouchEfiVariables = true;
            systemd-boot.enable = true;
        };
    };
}
