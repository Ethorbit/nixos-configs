{ inputs, config, ... }:

{
    nixpkgs.overlays = [
        (import ./overlays/nixpkgs-unstable.nix { inherit inputs; })
    ];
}
