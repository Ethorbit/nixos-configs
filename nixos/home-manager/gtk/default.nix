{ config, pkgs, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        # Fix for error: 
	# GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name ca.desrt.dconf was not provided by any .service files
	home.packages = [
	    pkgs.dconf
	];

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
