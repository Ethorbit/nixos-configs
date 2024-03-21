{
    description = "Ethorbit's NixOS Systems";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        
        home-manager = {
            url = "github:nix-community/home-manager/release-23.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        
        agenix.url = "github:ryantm/agenix";
        flatpaks.url = "github:GermanBread/declarative-flatpak/stable";
    
        NixOS-WSL = {
            url = "github:nix-community/NixOS-WSL";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { 
        self,
        nixpkgs,
        nixpkgs-unstable,
        home-manager,
        agenix,
        flatpaks,
        NixOS-WSL
    } @inputs: let
        inherit (self) outputs;
    in {
        nixosConfigurations = {
            # Home NAS, the centralized source of storage.
            "homenas" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs outputs; };
                modules = [
                    ./homenas/nixos
                    ./nixos/hardware/computer/qemu-vm
                    ./nixos
                    agenix.nixosModules.default
                ];
            };

            # Integrated Development Environment.
            # Not intended to be used directly, but it can be used as an independent OS if desired.
            "ide" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs outputs; };
                modules = [
                    ./nixos/components/ide/profiles/standalone
                    ./nixos/hardware/computer/qemu-vm
                    ./nixos
                    home-manager.nixosModules.default
                    agenix.nixosModules.default
                    NixOS-WSL.nixosModules.wsl
                ];
            };

            # Workstation OS, the powerhouse of all productivity.
            "workstation" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs outputs; };
                modules = [
                    ./workstation/nixos
                    ./nixos/hardware/computer/qemu-vm
                    ./nixos
                    home-manager.nixosModules.default
                    agenix.nixosModules.default
                    flatpaks.nixosModules.default
                ];
            };

            # NZC Game Community
            "nzc" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs outputs; };
                modules = [
                    ./nzc/nixos/profiles/production
                    ./nixos/hardware/computer/qemu-vm
                    ./nixos
                    home-manager.nixosModules.default
                    agenix.nixosModules.default
                ];
            };

            # NZC Game Community, but hosted at home
            "nzc/selfhosted" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs outputs; };
                modules = [
                    ./nzc/nixos/profiles/selfhosted
                    ./nixos/hardware/computer/qemu-vm
                    ./nixos
                    home-manager.nixosModules.default
                    agenix.nixosModules.default
                ];
            };

            # NZC Game Community, but for local development / testing
            "nzc/dev" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs outputs; };
                modules = [
                    ./nzc/nixos/profiles/dev
                    ./nixos/hardware/computer/qemu-vm
                    ./nixos
                    home-manager.nixosModules.default
                    agenix.nixosModules.default
                ];
            };
        };
    };
}
