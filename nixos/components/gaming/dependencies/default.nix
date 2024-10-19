{ config, ... }:

{
    # the linux kernel doesn't let containers or user
    # processes use CAP_SYS_NICE (which gamescope needs
    # for setting its own niceness)
    #
    # this is a workaround to force the niceness of gamescope
    services.ananicy = {
        enable = true;
        extraRules = [
            {
                name = "gamescope-wl";
                nice = -20;
            }
        ];
    };
}
