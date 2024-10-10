{ inputs, system, lib, ... }:

with inputs;

{
    imports = [
        ./nixos
        home-manager.nixosModules.default
        agenix.nixosModules.default
        flatpaks.nixosModules.nix-flatpak
        NixOS-WSL.nixosModules.wsl
    ];

    home-manager.sharedModules = [
        flatpaks.homeManagerModules.nix-flatpak
    ];

    age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    nixpkgs.overlays = [
        (self: super: {
            old = (import inputs.nixpkgs-old {
                system = super.system;
                config.allowUnfree = true;
            });

            unstable = (import inputs.nixpkgs-unstable {
                system = super.system;
                config.allowUnfree = true;
            });
        })
        nvidia-patch.overlays.default
    ];

    environment.systemPackages = [ agenix.packages.${system}.default ];
}
