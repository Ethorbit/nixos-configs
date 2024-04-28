{ config, lib, ... }:

{
    # Always have boot verbosity
    boot = {
        consoleLogLevel = lib.mkDefault 3;
        initrd.verbose = lib.mkDefault true;
    };
}
