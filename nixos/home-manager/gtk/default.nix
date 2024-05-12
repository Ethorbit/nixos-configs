{ config, pkgs, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home = with pkgs; {
            pointerCursor = {
                gtk.enable = true;
                name = "DMZ-Black";
                size = 20;
                package = vanilla-dmz;
            };
        };

        gtk = with pkgs; {
            enable = true;

            theme = {
                name = "Zukitre-dark";
                package = zuki-themes;
            };

            #cursorTheme

            iconTheme = {
                name = "Papirus";
                package = papirus-icon-theme;
            };

            gtk3.extraConfig = {
                gtk-application-prefer-dark-theme = 1;
            };

            gtk4.extraConfig = {
                gtk-application-prefer-dark-theme = 1;
            };
        };
    };
}
