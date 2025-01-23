{ config, lib, ... }:

with lib;

{
    services.xserver.windowManager.i3.enable = true;

    services.xserver.xautolock = {
        enable = true;
        time = mkDefault 120;
        locker = config.ethorbit.home-manager.i3.scripts.lock.outPath;
        nowlocker = config.ethorbit.home-manager.i3.scripts.lock.outPath;
        extraOptions = [
            "-detectsleep"
            "-lockaftersleep"
        ];
    };
}
