{ config, ... }:

{
    # the linux kernel doesn't let containers or user
    # processes use CAP_SYS_NICE (which gamescope needs
    # for setting its own niceness)
    #
    # by default, all systems have ananicy rules for things
    # like 'gamescope-wl' which will solve this issue (once
    # we enable ananicy)
    services.ananicy.enable = true;
}
