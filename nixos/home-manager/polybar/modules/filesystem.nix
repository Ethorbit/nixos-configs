{ config, ... }:

{
    home-manager.sharedModules = [ {
        services.polybar.config = {
            "module/filesystem" = {
                type = "internal/fs";
                interval = 25;

                mount-0 = "/";
                #mount-1 = /mnt/Int-HDD-Linux
                #mount-2 = /mnt/Int-SSD-One
                #mount-2 = /mnt/Ext-HDD-One
                #mount-4 = /mnt/Ext-HDD-Two
                #mount-5 = /mnt/Int-HDD-Windows

                label-mounted = "%{F#fffecc}%mountpoint%%{F-}: %percentage_used%%";
                label-unmounted = "%mountpoint%";
                label-unmounted-foreground = config.ethorbit.polybar.colors.foreground-alt;
                #label-mounted-underline = "#fffee3";
            };
        };
    } ];
}
