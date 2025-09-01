{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        git-lfs
        qt6.full
        python311Packages.grip
    ];
}
