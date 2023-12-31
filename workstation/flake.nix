{
    description = "Workstation OS, the powerhouse of all productivity.";

    inputs = {
        agenix.url = "github:ryantm/agenix";
        flatpaks.url = "github:GermanBread/declarative-flatpak/stable";
    };

    outputs = { self, nixpkgs, agenix, flatpaks }: {
        nixosConfigurations."workstation" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./nixos
                agenix.nixosModules.default
                flatpaks.nixosModules.default
            ];
        };
    };
}
