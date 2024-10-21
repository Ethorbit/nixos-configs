{ config, ... }:

{
    # Steam's compression during downloads is
    # very CPU-intensive and can cause
    # system-wide lag.
    #
    # We can set its nice level to give it
    # less CPU priority over other processes
    #
    # services.ananicy.extraRules = [
    #     {
    #         name = "steam";
    #         nice = 10;
    #     }
    #     {
    #         name = "steamwebhelper";
    #         nice = 10;
    #     }
    # ];
    #
    # ^ Commented out because it's making processes
    # (such as games) launched by steam get their
    # niceness increased, reducing game performance.
    #
    # As a workaround, you can set download limits to
    # decrease the amount of compression thus
    # less lag from downloads.
}
