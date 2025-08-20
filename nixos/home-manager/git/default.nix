{ homeModules, ... }:

{
    home-manager.sharedModules = 
     with homeModules; [
            git
        ] ++ [ {
            ethorbit.home-manager.git = {
                user.email = "Ethorbit@protonmail.com";
                user.name = "Ethorbit";
            };
        } ];
}
