{ config, ... }:

{
    imports = [
        ./openssh.nix
        ./restic.nix
        ./coturn.nix
    ];
}
