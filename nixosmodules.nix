{ inputs, system, ... }:

with inputs;
{
    imports = [
        ./nixos
        home-manager.nixosModules.default
        agenix.nixosModules.default
        flatpaks.nixosModules.default
        NixOS-WSL.nixosModules.wsl
    ];

    nixpkgs.overlays = [
        (self: super: {
            unstable = (import inputs.nixpkgs-unstable {
                system = super.system;
                config.allowUnfree = true;
            });
        })
        nvidia-patch.overlays.default
    ];
    environment.systemPackages = [ agenix.packages.${system}.default ];
}
