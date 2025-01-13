# Only works if you're using LightDM
#
# Override this script in your system if
# it needs to lock a different way..

{ config, lib, pkgs, ... }:

{
    options = with lib; {
        ethorbit.polybar.scripts.lock = lib.mkOption {
            type = types.package;
            default = (pkgs.writeShellScript "lock.sh" ''
                ${pkgs.lightdm}/bin/dm-tool switch-to-greeter
            '');
        };
    };
}

