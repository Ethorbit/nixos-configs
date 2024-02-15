{ config, ... }:

{
    imports = [
        ./restic.nix
        ./openssh.nix
    ];
}
