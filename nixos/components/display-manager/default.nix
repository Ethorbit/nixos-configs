{ config, ... }:

{
    # - Turn off annoying X bell
    # - Turn off useless screensaver
    # - Set inactivity suspend to 2 hours
    services.xserver.displayManager.sessionCommands = ''
    xset -b
    xset s off
    xset dpms 7200 0 0
    '';
}
