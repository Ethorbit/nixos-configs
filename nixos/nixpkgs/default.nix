{ inputs, config, ... }:

{
    nixpkgs.config.allowUnfree = true;

    nixpkgs.overlays = [
        (import ./overlays/nixpkgs-unstable.nix { inherit inputs; })
    ];
}
