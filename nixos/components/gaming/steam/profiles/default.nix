{ config, ... }:

{
    # Steam's compression during downloads is
    # very CPU-intensive and can cause
    # system-wide lag.
    #
    # We can set its nice level to give it
    # less CPU priority over other processes
    #
    services.ananicy.extraRules = [
        # Processes running with -20 niceness can
        # set the niceness value of its child processes
        #
        # So setting steam to -20 means games launched
        # should also get -20
        {
            name = "steam";
            nice = -20;
        }
    ];

    # As a workaround to downloads lagging entire system,
    # you can set a download limit to decrease the amount of
    # compression thus less CPU lag from downloads.
    # eg. 20000 kbps
}
