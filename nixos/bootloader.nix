{ config, lib, ... }:

{
    boot = with lib; {
        # Always have boot verbosity
        consoleLogLevel = mkDefault 3;
        initrd.verbose = mkDefault true;
        # Enable Sysrq REISUB
        kernel.sysctl."kernel.sysrq" = mkDefault 502;
    };
}
