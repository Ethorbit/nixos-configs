{ config, ... }:

{
    imports = [
        ./openssh.nix
        ./coturn.nix
        ./traefik.nix
    ];
}
