{ config, ... }:

{
    imports = [
        ../../default.nix
        ./packages.nix
        ./hardware.nix
        ./services.nix
    ];
}
