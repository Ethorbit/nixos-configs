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
