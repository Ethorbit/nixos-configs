{ config, lib, ... }:

with lib;

{
    services.xserver.windowManager.i3.enable = true;

    programs.xss-lock = {
        enable = mkDefault true;
        lockerCommand = mkDefault config.ethorbit.home-manager.i3.scripts.lock.outPath;
        extraOptions = mkDefault [
            "--transfer-sleep-lock"
        ];
    };
}
