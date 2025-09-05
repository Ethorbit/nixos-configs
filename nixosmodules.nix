{ inputs, system, lib, ... }:

with inputs;

{
    imports = [
        ./nixos
        ethorbit-packages.nixosModules.default
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
                config.allowunfree = true;
            });

            stable = (import inputs.nixpkgs {
                system = super.system;
                config.allowunfree = true;
            });

            unstable = (import inputs.nixpkgs-unstable {
                system = super.system;
                config.allowunfree = true;
            });
        })

        ethorbit-packages.overlays.default
        nvidia-patch.overlays.default
    ];

    environment.systemPackages = [ agenix.packages.${system}.default ];
}
