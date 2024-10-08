{ config, lib, pkgs, ... }:

with lib;

{
    options.ethorbit.home-manager.xdg = {
        defaults = {
            file = mkOption {
                type = types.str;
                default = "nautilus.desktop";
            };

            browser = mkOption {
                type = types.str;
                default = "firefox.desktop";
            };

            audio = mkOption {
                type = types.str;
                default = "vlc.desktop";
            };
        };
    };

    config = {
        home-manager.sharedModules = [ {
            xdg = {
                enable = true;
                mime.enable = true;
                mimeApps = with lib; {
                    enable = true;
                    defaultApplications = with config.ethorbit.home-manager.xdg.defaults; {
                        "inode/directory" = mkDefault [ "${file}" ];
                        "text/html" = [ "${browser}" ];
                        "x-scheme-handler/http" = [ "${browser}" ];
                        "x-scheme-handler/https" = [ "${browser}" ];
                        "x-scheme-handler/about" = [ "${browser}" ];
                        "x-scheme-handler/unknown" = [ "${browser}" ];
                        "x-scheme-handler/chrome" = [ "${browser}" ];
                        "x-scheme-handler/ftp" = mkDefault [ "${browser}" ];
                        "application/xhtml+xml" = [ "${browser}" ];
                        "application/x-extension-htm" = [ "${browser}" ];
                        "application/x-extension-html" = [ "${browser}" ];
                        "application/x-extension-shtml" = [ "${browser}" ];
                        "application/x-extension-xhtml" = [ "${browser}" ];
                        "application/x-extension-xht" = [ "${browser}" ];
                        "application/pdf" = mkDefault [ "${browser}" ];
                        "audio/*" = mkDefault [ "${audio}" ];
                        "audio/ogg" = mkDefault [ "${audio}" ];
                        "audio/opus" = mkDefault [ "${audio}" ];
                    };
                };
            };

            # BIG PROBLEM!
            # Even with the above, xdg-settings get default-web-browser returns the wrong thing.
            # xdg-settings set default-web-browser fixes it, but it needs to be run interactively.
            # Because of this, I do not know of any automated solution to set the default web browser.
        } ];
    };
}
