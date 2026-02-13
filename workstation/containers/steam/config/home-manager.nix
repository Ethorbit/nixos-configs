{ pkgs, config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file."hm-update".text = "update";

        # Fix for ranger not working inside of Steam
        # We just need to modify the exec to launch ranger
        # with a terminal emulator
        xdg.desktopEntries."ranger" = {
            type = "Application";
            name = "ranger";
            comment = "Launches the ranger file manager";
            terminal = true;
            exec = "${pkgs.kitty}/bin/kitty -e ${pkgs.ranger}/bin/ranger";
            categories = [
                "ConsoleOnly"
                "System"
                "FileTools"
                "FileManager"
            ];
            mimeType = [
                "inode/directory"
            ];
            settings.Keywords = "File;Manager;Browser;Explorer;Launcher;Vi;Vim;Python";
        };
    };
}
