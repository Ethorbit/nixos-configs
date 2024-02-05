{ config, pkgs, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".moc/config".text = ''
            Theme = ${pkgs.moc}/share/moc/themes/transparent-background 
            Shuffle = yes
            Autonext = yes
            MusicDir = $HOME/Music/
            SoundDriver = PULSEAUDIO
        '';
    };
}
