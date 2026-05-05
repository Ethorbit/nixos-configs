{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        git-lfs
        python311Packages.grip
    ];
}
