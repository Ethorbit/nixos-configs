{ config, ... }:

{
    imports = [
        ../../default.nix
        ./packages.nix
        ./services.nix
    ];
}
