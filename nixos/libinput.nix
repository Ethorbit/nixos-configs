{ config, lib, ... }:

{
    services.xserver.libinput = with lib; {
        mouse = {
            accelProfile = mkDefault "flat";
            accelSpeed = mkDefault "0.0";
        };

        touchpad = {
            accelProfile = mkDefault "flat";
            accelSpeed = mkDefault "0.0";
        };
    };
}
