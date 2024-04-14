{ config, pkgs, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        gtk = {
            enable = true;

            theme = {
                name = "zukitre-dark";
                package = pkgs.zuki-themes;
            };

            gtk3.extraConfig = {
                Settings = ''
                    gtk-application-prefer-dark-theme=1
                '';
            };

            gtk4.extraConfig = {
                Settings = ''
                    gtk-application-prefer-dark-theme=1
                '';
            };
        };
    };
}
