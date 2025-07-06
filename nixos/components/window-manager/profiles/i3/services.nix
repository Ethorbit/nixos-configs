{ pkgs, lib, ... }:

with lib;

let
    script = pkgs.writeShellScriptBin "lock.sh" ''
        ${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 10 20
    '';
in
{
    services.xserver.windowManager.i3.enable = true;

    programs.xss-lock = {
        enable = mkDefault true;
        lockerCommand = mkDefault script.outPath;
        extraOptions = mkDefault [
            "--transfer-sleep-lock"
        ];
    };
}
