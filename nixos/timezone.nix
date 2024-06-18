{ config, lib, ... }:

with lib;
{
    time.timeZone = mkDefault "America/Los_Angeles";
    environment.etc."timezone".text = mkDefault config.time.timeZone;
}
