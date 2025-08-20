{  homeModules, ... }:

{
    imports = [
        ../../../../home-manager/git
    ];

    home-manager.sharedModules = 
        with homeModules; [
            neovim
            ranger
        ];
}
