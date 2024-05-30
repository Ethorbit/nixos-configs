{ config, ... }:

{
    imports = [
        ./restic.nix
        ./network
    ];
}
