{ config, ... }:

{
    imports = [
        ./openssh.nix
        ./coturn.nix
        ./authelia.nix
        ./traefik.nix
    ];
}
