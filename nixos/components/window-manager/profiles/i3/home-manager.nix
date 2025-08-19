{ lib, pkgs, homeModules, ... }:

{
    home-manager.sharedModules = with homeModules; [
        i3
    ] ++ [
        {
            ethorbit.home-manager.polybar.scripts.lock = lib.mkDefault (pkgs.writeShellScript "lock.sh" ''
                 ${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 10 20
            '');
        }
    ];
}
