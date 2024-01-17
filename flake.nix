{
    description = "Ethorbit's NixOS Systems";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
        agenix.url = "github:ryantm/agenix";
        flatpaks.url = "github:GermanBread/declarative-flatpak/stable";
    };

    outputs = { self, nixpkgs, agenix, flatpaks }: {
        nixosConfigurations = {
            # Home NAS, the centralized source of storage.
            "homenas" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./homenas/nixos
                    ./options.nix
                ];
            };

            # Workstation OS, the powerhouse of all productivity.
            "workstation" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./workstation/nixos
                    ./options.nix
                    agenix.nixosModules.default
                    flatpaks.nixosModules.default
                ];
            };

            # NZC Game Community
            "nzc" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./nzc/nixos
                    ./options.nix
                    agenix.nixosModules.default
                ];
            };

            # NZC Game Community, but hosted at home
            "nzc/selfhosted" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./nzc/nixos/selfhosted
                    ./options.nix
                    agenix.nixosModules.default
                ];
            };
        };
    };
}
