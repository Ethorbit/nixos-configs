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

        home.file.".config/rofi/launchers_custom" = {
            source = ./config/launchers_custom;
            executable = true;
        };

        # Symlink the directories from adi1090x's rofi repository that we installed via custom package
        home.file.".config/rofi" = {
            source = "${config.ethorbit.pkgs.rofi-adi1090x}/.config/rofi";
            recursive = true;
        };
    };
}
