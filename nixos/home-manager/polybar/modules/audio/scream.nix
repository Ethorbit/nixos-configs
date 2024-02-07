{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username}.services.polybar.config = {
        "module/scream" = {
            exec = "${config.ethorbit.polybar.scripts.scream.scream.outPath}";
            type = "custom/script";
            click-left = "${config.ethorbit.polybar.scripts.scream.toggle.outPath}";
            interval = 1;
            format-underline = "#ffffff";
        };
    };
}
