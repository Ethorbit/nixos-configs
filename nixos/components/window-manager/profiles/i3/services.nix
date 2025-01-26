{ config, lib, ... }:

with lib;

{
    services.xserver.windowManager.i3.enable = true;

    # Doesn't work. We'll add our personal implementation of something that DOES
    #services.xserver.xautolock = {
    #    enable = true;
    #    time = mkDefault 15;
    #    locker = config.ethorbit.home-manager.i3.scripts.lock.outPath;
    #    nowlocker = config.ethorbit.home-manager.i3.scripts.lock.outPath;
    #};
    ethorbit.services.xidlehook = {
        enable = mkDefault true;
        command = mkDefault config.ethorbit.home-manager.i3.scripts.lock.outPath;
    };

    programs.xss-lock = {
        enable = mkDefault true;
        lockerCommand = mkDefault config.ethorbit.home-manager.i3.scripts.lock.outPath;
        extraOptions = mkDefault [
            "--transfer-sleep-lock"
        ];
    };
}
