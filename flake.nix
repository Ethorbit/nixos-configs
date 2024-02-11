{
    description = "Ethorbit's NixOS Systems";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
        home-manager = {
            url = "github:nix-community/home-manager/release-23.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        agenix.url = "github:ryantm/agenix";
        flatpaks.url = "github:GermanBread/declarative-flatpak/stable";
    };

    outputs = { self, nixpkgs, home-manager, agenix, flatpaks }: {
        nixosConfigurations = {
            # Home NAS, the centralized source of storage.
            "homenas" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./homenas/nixos
                    ./nixos/computer/qemu-vm
                    ./nixos
                    agenix.nixosModules.default
                ];
            };

            # Integrated Development Environment.
            # Not intended to be used directly, but it can be used as an independent OS if desired.
            "ide" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./nixos/components/ide/profiles/standalone
                    ./nixos/computer/qemu-vm
                    ./nixos
                    home-manager.nixosModules.default
                    agenix.nixosModules.default
                ];
            };

            # Workstation OS, the powerhouse of all productivity.
            "workstation" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./workstation/nixos
                    ./nixos/computer/qemu-vm
                    ./nixos
                    agenix.nixosModules.default
                    flatpaks.nixosModules.default
                ];
            };

            # NZC Game Community
            "nzc" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./nzc/nixos
                    ./nixos/computer/qemu-vm
                    ./nixos
                    agenix.nixosModules.default
                ];
            };

            # NZC Game Community, but for local development
            "nzc/dev" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./nzc/nixos/profiles/dev
                    ./nixos/computer/qemu-vm
                    ./nixos
                    agenix.nixosModules.default
                ];
            };

            # NZC Game Community, but hosted at home
            "nzc/selfhosted" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./nzc/nixos/profiles/selfhosted
                    ./nixos/computer/qemu-vm
                    ./nixos
                    agenix.nixosModules.default
                ];
            };
        };
    };
}
