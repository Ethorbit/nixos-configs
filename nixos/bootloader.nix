{ config, lib, ... }:

{
    boot = with lib; {
        # Always have boot verbosity
        consoleLogLevel = mkDefault 3;
        initrd.verbose = mkDefault true;
        # Enable Sysrq fully
        kernel.sysctl."kernel.sysrq" = mkDefault 1;
    };

