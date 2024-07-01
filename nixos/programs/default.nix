{ config, lib, ... }:

{
    programs = with lib; {
        ssh.askPassword = mkDefault "";
        nano.enable = mkDefault false;
        dconf.enable = mkDefault true;
        zsh.enable = true;
        bash.blesh.enable = mkDefault true;
    };
}
