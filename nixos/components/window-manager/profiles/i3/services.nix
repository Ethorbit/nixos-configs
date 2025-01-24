{ config, lib, ... }:

with lib;

{
    services.xserver.windowManager.i3.enable = true;

    programs.xss-lock = {
        enable = true;
        lockerCommand = config.ethorbit.home-manager.i3.scripts.lock.outPath;
        extraOptions = [

        ];
    };
}
