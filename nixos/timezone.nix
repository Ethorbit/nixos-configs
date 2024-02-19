{ config, ... }:

{
    time.timeZone = "America/Los_Angeles";
    environment.etc."timezone".text = config.time.timeZone;
}
