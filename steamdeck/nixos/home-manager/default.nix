{ config, ... }:

{
    imports = [
        ./prompt.nix
        ./desktop.nix
    ];

    # Idk home-manager is a bit brain dead and won't update sharedModules
    # unless I change a file as the user. \o/ Ignore this! 
    home-manager.users."${config.ethorbit.users.primary.username}" = { config, ... }: {
        home.file."update-time".text = ''yay it updates my files now (x12)'';
    };
}
