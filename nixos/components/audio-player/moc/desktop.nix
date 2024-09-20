{ config, pkgs, ... }:

let
    script = pkgs.writeShellScriptBin "script" ''
       if [ "$1" ]; then
           ${pkgs.moc}/bin/mocp mocp -l "$1"
       else
           ${pkgs.moc}/bin/mocp mocp, mode "default"
       fi
    '';
in
{
    environment.systemPackages = with pkgs; [
        (pkgs.makeDesktopItem {
            name = "moc";
            desktopName = "moc";
            exec = ''/usr/bin/env sh ${script}/bin/script "%f"'';
            terminal = true;
        })
    ];
}
