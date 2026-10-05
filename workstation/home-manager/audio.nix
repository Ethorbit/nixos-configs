{ ... }:

{
    home-manager.sharedModules = [ {
        programs.bash.shellAliases = {
            mocp = "PULSE_LATENCY_MSEC=60 mocp";
        };

        programs.zsh.shellAliases = {
            mocp = "PULSE_LATENCY_MSEC=60 mocp";
        };
    } ];
}
