{ homeModules, ... }:

{
    home-manager.sharedModules = 
     with homeModules; [
            git
        ] ++ [ {
            ethorbit.home-manager.git = {
                user.email = "11908638+Ethorbit@users.noreply.github.com";
                user.name = "Ethorbit";
            };
        } ];
}
