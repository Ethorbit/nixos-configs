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
            {
                name = "gamescope-brokey";
                nice = -20;
            }
            {
                name = "wine64-preloader";
                type = "Game";
            }

            {
                name = "prismrun";
                type = "Game";
            }

            # if we make steam a game, it will pass its niceness
            # to its child processes (eg. games that it launches)
            # this helps for games that don't yet have a rule
            #
            # this also means we don't need to make a rule for every game
            # in existence, only the ones that don't receive the niceness
            {
                name = "steam";
                type = "Game";
            }

            {
                name = "Brotato.exe";
                type = "Game";
            }
            {
                name = "idTechLauncher.exe";
                type = "Game";
            }
            {
                name = "DOOMEternalx64v";
                type = "Game";
            }
            {
                name = "Win64\\Paladins.exe";
                type = "Game";
            }
        ];
    };
}
