# The X Session # for each system
# 1000 + # will also be the system's UID.

{ config, lib, ... }:

{
    options.ethorbit.workstation.xorg.sessionNumbers = with lib; mkOption {
        type = types.attrs;
        default = {
            "workstation" = 0;
            "development" = 1;
            "socials" = 2;
            "shopping" = 3;
            "media" = 4;
            "games" = 5;
        };
    };
}
