{ config, ... }:

{
    imports = [
        ./libinput.nix
        ./irqbalance.nix
        ./ananicy.nix
        ./openssh.nix
        ./xidlehook.nix
    ];
}
