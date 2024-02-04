{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        feh
        moc
    ];
}
