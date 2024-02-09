{ config, pkgs, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        programs.rofi.package = (pkgs.rofi.override {
            plugins = [
                pkgs.rofi-emoji
            ];
        });

        programs.rofi.enable = true;

        home.file.".config/rofi/rofi-rofi.sh" = {
            source = ./config/rofi-rofi.sh;
            executable = true;
        };

        home.file.".config/rofi/powermenu" = {
            source = ./config/powermenu;
            executable = true;
        };

        home.file.".config/rofi/launchers" = {
            source = ./config/launchers;
            executable = true;
        };

        home.file.".config/rofi/applets" = {
            source = ./config/applets;
            executable = true;
        };
    };
}
