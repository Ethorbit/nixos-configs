{ config, ... }:

{
    imports = [
        ./irqbalance.nix
        ./ananicy.nix
        ./openssh.nix
        ./xidlehook.nix
    ];
}
