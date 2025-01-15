# I made these because running Steam under native Gamescope
# was the ONLY way I could get my games to run with more 
# than 60 fps in Gamescope
#
# Still, the FPS is lower with Gamescope than without Gamescope
# by about 20-30 frames, but I'm planning on switching to AMD
# soon since this is likely a proprietary driver problem

{ config, pkgs, lib, ... }:

with lib;
with pkgs;

let
    flatpak-app = "com.valvesoftware.Steam";
    flatpak-app-command = writeShellScriptBin "wrapper" ''steam'';
    gamescope-command = "${gamescope}/bin/gamescope ${escapeShellArgs config.ethorbit.components.gaming.steam.flatpak.gamescope.flags}";
    gamemode-command = "${gamemode}/bin/gamemoderun --";

    wrapper = writeShellScriptBin "gamescope-steam.sh" ''
        ${gamescope-command} ${gamemode-command} flatpak run --branch=stable --arch=x86_64 --command=${flatpak-app-command}/bin/wrapper ${flatpak-app};
    '';
    offline-wrapper = writeShellScriptBin "gamescope-steam-offline.sh" ''
        ${gamescope-command} ${gamemode-command} flatpak run --unshare=network --branch=stable --arch=x86_64 --command=${flatpak-app-command}/bin/wrapper ${flatpak-app};
    '';
    mangohud-wrapper = writeShellScriptBin "gamescope-steam-mangohud.sh" ''
        MANGOHUD=1 ${wrapper}/bin/gamescope-steam.sh
    '';
    mangohud-offline-wrapper = writeShellScriptBin "gamescope-steam-mangohud-offline.sh" ''
        MANGOHUD=1 ${offline-wrapper}/bin/gamescope-steam-offline.sh
    '';

    defaultProps = {
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
in
{
    environment.systemPackages = with pkgs; [
        wrapper
        offline-wrapper
        mangohud-wrapper
        mangohud-offline-wrapper
    ];

    home-manager.sharedModules = mkIf config.ethorbit.components.gaming.steam.flatpak.gamescope.enable [ {
        xdg.desktopEntries."gamescope-steam" = mkMerge [
            defaultProps
            {
                name = "Steam (Gamescope)";
                comment = "Application for managing and playing games on Steam, inside Gamescope";
                exec = "${wrapper}/bin/gamescope-steam.sh";
            }
        ];

        xdg.desktopEntries."gamescope-steam-offline" = mkMerge [
            defaultProps
            {
                name = "Steam (Gamescope) (Offline)";
                comment = "Application for managing and playing games on Steam without internet, inside Gamescope";
                exec = "${offline-wrapper}/bin/gamescope-steam-offline.sh";
            }
        ];

        xdg.desktopEntries."gamescope-steam-mangohud" = mkMerge [
            defaultProps
            {
                name = "Steam (Gamescope + MangoHUD)";
                comment = "Application for managing and playing games on Steam, inside Gamescope";
                exec = "${mangohud-wrapper}/bin/gamescope-steam-mangohud.sh";
            }
        ];

        xdg.desktopEntries."gamescope-steam-offline-mangohud" = mkMerge [
            defaultProps
            {
                name = "Steam (Gamescope + MangoHUD) (Offline)";
                comment = "Application for managing and playing games on Steam without internet, inside Gamescope";
                exec = "${mangohud-offline-wrapper}/bin/gamescope-steam-mangohud-offline.sh";
            }
        ];
    } ];
}
