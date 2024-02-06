{ config, ... }:

{
    imports = [
        ./gpu-usage.nix
        ./gpu-temperature.nix
        ./gpu.nix
    ];
}
