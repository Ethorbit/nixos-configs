{ config, ... }:

{
    services.xserver = {
        enable = true;
        windowManager.i3.enable = true;

        displayManager = {
            lightdm = {
                enable = true;
                greeters.gtk.enable = true;
            };

            defaultSession = "none+i3";
            autoLogin.user = config.ethorbit.users.primary.username;
        };
    };
}
