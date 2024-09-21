{ config, pkgs, ... }:

{
    imports = [
        ../../../home-manager/moc
        ./desktop.nix
    ];
}
