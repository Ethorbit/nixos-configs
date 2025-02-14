{ config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./bootloader.nix
        ./networking.nix
        ./services.nix
        ./packages
        ./users.nix
        ./desktop.nix
    ];

    jovian.steam = {
        enable = true;
        autoStart = true;
        # see desktop.nix
        desktopSession = "xfce";
        # see users.nix
        user = "${config.ethorbit.users.primary.username}";
    };

    # Idk home-manager is a bit brain dead and won't update sharedModules
    # unless I change a file as the user. \o/ Ignore this! 
    home-manager.users."${config.ethorbit.users.primary.username}" = { config, ... }: {
        home.file."update-time".text = ''yay it updates my files now (x2)'';
    };
}
