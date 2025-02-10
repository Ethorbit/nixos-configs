# Now you can launch Steam (Offline) where all processes inside
# the Steam flatpak (including games and commands) have
# no internet connectivity whatsoever
#
# This is different from Steam's Offline Mode
# It's useful if a game's networking is causing issues with gameplay
#
# For example, DOOM Eternal's Bethesda communication breaks the settings menu
# as it waits to connect indefinitely with an uncloseable menu, forcing you
# to quit the game

{ config, pkgs, lib, ... }:

let
    cfg = config.ethorbit.components.gaming.steam.flatpak;
    script = (pkgs.writeShellScript "steam-offline.sh" ''
        ${cfg.gamescope.commands.gamemode} \
            flatpak run --unshare=network --branch=stable --arch=x86_64 --command=/app/bin/steam --file-forwarding com.valvesoftware.Steam
    '');
    command = (pkgs.writeShellScript "command" ''
        ${cfg.steam-acolyte.command} --exe ${script.outPath}
    '');
in
{
    home-manager.sharedModules = (
        if (config.ethorbit.components.gaming.steam.flatpak.offline.enable) then [ {
            xdg.desktopEntries."steam-offline" = {
                name = "Steam (Offline)";
                comment = "Application for managing and playing games on Steam without internet";
                exec = "${command.outPath} @@u %U @@";
                icon = "com.valvesoftware.Steam";
                terminal = false;
                type = "Application";
                categories = [
                    "FileTransfer"
                    "Game"
                ];
                mimeType = [
                    "x-scheme-handler/steam"
                    "x-scheme-handler/steamlink"
                ];
                settings = {
                    X-Desktop-File-Install-Version = "0.27";
                    StartupWMClass = "Steam";
                    X-Flatpak-RenamedFrom = "steam-offline.desktop";
                    X-Flatpak-Tags = "proprietary";
                    X-Flatpak = "com.valvesoftware.Steam";
                };
            };
        } ] else [ { } ]
    );
}
