{ config, ... }:

{
    imports = [
        ./ananicy.nix
        ./openssh.nix
        ./xidlehook.nix
    ];
}
