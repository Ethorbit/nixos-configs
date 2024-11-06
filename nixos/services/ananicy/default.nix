# ananicy already ships with default
# rules for many things
#
# so I'm just extending support for
# applications I use that don't yet
# have a default rule

{ config, ... }:

{
    imports = [
        ./games.nix
    ];

    #services.ananicy = {
        #settings = {
            #"loglevel" = "debug";
            #"log_applied_rule" = true;
        #};
    #};
}
