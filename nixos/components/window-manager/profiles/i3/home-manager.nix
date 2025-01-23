{ config, lib, pkgs, ... }:

{
    imports = [
        ../../../../home-manager/i3
    ];

    ethorbit.polybar.scripts.lock = lib.mkDefault (pkgs.writeShellScript "lock.sh" ''
        ${config.ethorbit.home-manager.i3.scripts.lock.outPath}
    '');
}
