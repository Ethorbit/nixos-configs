{ config, pkgs, ... }:

{
    #environment.systemPackages = with pkgs; [
    #    steam
    #];
    programs.steam = {
        enable = true;
    };
}
