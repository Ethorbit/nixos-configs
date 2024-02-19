{ inputs, config, ... }:

{
    nixpkgs = {
        config.allowUnfree = true;
        overlays = [
            (import ./overlays/nixpkgs-unstable.nix { inherit inputs; })
        ];
    };
}
