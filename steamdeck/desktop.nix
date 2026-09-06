{ pkgs, ... }:

let
    gameModeScript = pkgs.writeShellScript "steamos-switch-to-game-mode" ''
        /run/current-system/sw/bin/steamosctl switch-to-game-mode
        xfce4-session-logout --logout --fast
    '';
in
{
    imports = [
        ../nixos/components/display-server/profiles/xserver
        ../nixos/components/desktop-environment/profiles/xfce
    ];

    # Add 'startx' or else desktop mode won't work
    services.xserver.displayManager.startx.enable = true;

    environment.systemPackages = [
        (pkgs.makeDesktopItem {
            name = "steamos-game-mode";
            desktopName = "Switch to Game Mode";
            comment = "Switch this SteamOS session back to Game Mode";
            exec = "${gameModeScript}";
            icon = "input-gaming";
            categories = [ "System" "Game" ];
        })
    ];
}
