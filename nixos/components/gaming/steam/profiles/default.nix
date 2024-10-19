{ config, ... }:

{
    # Steam's compression during downloads is
    # very CPU-intensive and can cause
    # system-wide lag.
    #
    # We can set its nice level to give it
    # less CPU priority over other processes
    services.ananicy.extraRules = [
        {
            name = "steam";
            nice = 10;
        }
        {
            name = "steamwebhelper";
            nice = 10;
        }
    ];
}
