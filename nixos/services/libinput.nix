{ config, lib, ... }:

{
    services.libinput = with lib; {
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
