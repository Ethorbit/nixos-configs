{  homeModules, ... }:

{
    imports = [
        ../../../../home-manager/git
        ../../../../home-manager/ranger
    ];

    home-manager.sharedModules = 
        with homeModules; [
            neovim
        ];
}
