{ config, ... }:

{
    # the linux kernel doesn't let containers or user
    # processes use CAP_SYS_NICE (which game tools need
    # for setting niceness)
    #
    # We will control niceness with ananicy as a workaround
    services.ananicy = {
        enable = true;
        extraRules = [
            {
                name = "gamescope-wl";
                nice = -20;
            }

            # if we make steam a game, it will pass its niceness
            # to its child processes (eg. games that it launches)
            # this helps for games that don't yet have a rule
            #
            # this also means we don't need to make a rule for every game
            # in existence, only the ones that don't receive the niceness
            {
                name = "steam";
                type = "game";
            }

            {
                name = "Brotato.exe";
                type = "game";
            }
            {
                name = "idTechLauncher.exe";
                type = "game-launcher";
            }
            {
                name = "DOOMEternalx64v";
                type = "game";
            }
        ];
    };
}
