{ config, pkgs, ... }:

{
    imports = [
        ./desktop.nix
    ];

    home-manager.sharedModules = [ {
        home.file.".moc/config".text = ''
            Theme = ${pkgs.moc}/share/moc/themes/transparent-background 
            Shuffle = yes
            Autonext = yes
            MusicDir = $HOME/Music/
            SoundDriver = PULSEAUDIO
        '';
    } ];
}
