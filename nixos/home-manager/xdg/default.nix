{ config, lib, pkgs, ... }:

{
    options.ethorbit.home-manager.xdg = with lib; {
        defaultBrowser = mkOption {
            type = types.str;
            default = "firefox.desktop";
        };

        defaultAudioPlayer = mkOption {
            type = types.str;
            default = "vlc.desktop";
        };
    };

    config = {
        home-manager.users.${config.ethorbit.users.primary.username} = { lib, ... }: {
            xdg = {
                enable = true;
                mime.enable = true;
                mimeApps = with lib; {
                    enable = true;
                    defaultApplications = {
                        "text/html" = [ "${config.ethorbit.home-manager.xdg.defaultBrowser}" ];
                        "x-scheme-handler/http" = [ "${config.ethorbit.home-manager.xdg.defaultBrowser}" ];
                        "x-scheme-handler/https" = [ "${config.ethorbit.home-manager.xdg.defaultBrowser}" ];
                        "x-scheme-handler/about" = [ "${config.ethorbit.home-manager.xdg.defaultBrowser}" ];
                        "x-scheme-handler/unknown" = [ "${config.ethorbit.home-manager.xdg.defaultBrowser}" ];
                        "x-scheme-handler/chrome" = [ "${config.ethorbit.home-manager.xdg.defaultBrowser}" ];
                        "x-scheme-handler/ftp" = mkDefault [ "${config.ethorbit.home-manager.xdg.defaultBrowser}" ];
                        "application/xhtml+xml" = [ "${config.ethorbit.home-manager.xdg.defaultBrowser}" ];
                        "application/x-extension-htm" = [ "${config.ethorbit.home-manager.xdg.defaultBrowser}" ];
                        "application/x-extension-html" = [ "${config.ethorbit.home-manager.xdg.defaultBrowser}" ];
                        "application/x-extension-shtml" = [ "${config.ethorbit.home-manager.xdg.defaultBrowser}" ];
                        "application/x-extension-xhtml" = [ "${config.ethorbit.home-manager.xdg.defaultBrowser}" ];
                        "application/x-extension-xht" = [ "${config.ethorbit.home-manager.xdg.defaultBrowser}" ];
                        "application/pdf" = mkDefault [ "${config.ethorbit.home-manager.xdg.defaultBrowser}" ];
                        "audio/*" = mkDefault [ "${config.ethorbit.home-manager.xdg.defaultAudioPlayer}" ];
                        "audio/ogg" = mkDefault [ "${config.ethorbit.home-manager.xdg.defaultAudioPlayer}" ];
                        "audio/opus" = mkDefault [ "${config.ethorbit.home-manager.xdg.defaultAudioPlayer}" ];
                    };
                };
            };

            # BIG PROBLEM!
            # Even with the above, xdg-settings get default-web-browser returns the wrong thing.
            # xdg-settings set default-web-browser fixes it, but it needs to be run interactively.
            # Because of this, I do not know of any automated solution to set the default web browser.
        };
    };
}
