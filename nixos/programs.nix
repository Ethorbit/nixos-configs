{ config, ... }:

{
    programs = {
        ssh.askPassword = "";
        nano.enable = false;
        dconf.enable = true;
    };
}
