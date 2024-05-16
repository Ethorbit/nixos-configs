{ config, ... }:

{
    imports = [
        ./openssh.nix
        ./restic.nix
    ];
}
