{ inputs, ... }:

self: super: {
    unstable = (import inputs.nixpkgs-unstable {
        system = super.system;
        config.allowUnfree = true;
    });
}
