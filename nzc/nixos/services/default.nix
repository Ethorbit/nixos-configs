{ config, ... }:

{
    imports = [
        ./git-clone.nix
        ./restic.nix
        ./openssh.nix
    ];
}
