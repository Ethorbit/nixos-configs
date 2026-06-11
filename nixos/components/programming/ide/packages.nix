{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        git-lfs
        python3Packages.grip
    ];
}
