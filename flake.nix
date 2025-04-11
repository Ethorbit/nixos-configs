{
    description = "Ethorbit's NixOS Systems";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
        nixpkgs-old.url = "github:nixos/nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager/release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager-old = {
            url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs-old";
        };

        home-manager-unstable = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs-unstable";
        };

        agenix.url = "github:ryantm/agenix";
        # having endless problems trying to get this working in Home Manager
        #flatpaks.url = "github:GermanBread/declarative-flatpak/stable-v3";
        # but this one actually works as intended
        flatpaks.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";

        nvidia-patch = {
            url = "github:icewind1991/nvidia-patch-nixos";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # WSL support
        NixOS-WSL = {
            url = "github:nix-community/NixOS-WSL";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # Steam Deck support
        Jovian-NixOS = {
            url = "github:Jovian-Experiments/Jovian-NixOS";
            inputs.nixpkgs.follows = "nixpkgs-unstable";
        };
    };

    outputs = { 
        self,
        nixpkgs,
        nixpkgs-old,
        nixpkgs-unstable,
        home-manager,
        home-manager-old,
        home-manager-unstable,
        agenix,
        flatpaks,
        nvidia-patch,
        NixOS-WSL,
        Jovian-NixOS
    } @inputs: let
        inherit (self) outputs;
        system = "x86_64-linux";
    in {
        nixosConfigurations = {
            # Work, yeah there's nothing fancy to describe this with..
            "work" = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs outputs system; };
                modules = [
                    home-manager.nixosModules.default
                    ./work/nixos
                    ./nixosmodules.nix
                ];
            };

            # Home NAS, the centralized source of storage.
            "homenas" = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs outputs system; };
                modules = [
                    home-manager.nixosModules.default
                    ./homenas/nixos
                    ./nixos/hardware/vm/qemu
                    ./nixosmodules.nix
                ];
            };

            # Integrated Development Environment.
            # Not intended to be used directly, but it can be used as an independent OS if desired.
            "ide/cli" = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs outputs system; };
                modules = [
                    home-manager.nixosModules.default
                    ./nixos/components/programming/ide/profiles/standalone/profiles/cli
                    ./nixos/hardware/container/wsl
                    ./nixosmodules.nix
                ];
            };
            "ide/desktop" = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs outputs system; };
                modules = [
                    home-manager.nixosModules.default
                    ./nixos/components/programming/ide/profiles/standalone/profiles/desktop
                    ./nixos/hardware/vm/qemu
                    ./nixosmodules.nix
                ];
            };

            # For quick NVIDIA container computation work
            # also useful for virtual desktop streaming
            "headless-nvidia" = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs outputs system; };
                modules = [
                    home-manager.nixosModules.default
                    ./headless-nvidia/nixos
                    ./nixosmodules.nix
                ];
            };

            # Workstation OS, the general-purpose powerhouse for monster rigs
            "workstation" = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs outputs system; };
                modules = [
                    home-manager.nixosModules.default
                    ./workstation/nixos
                    ./nixosmodules.nix
                ];
            };

            # Steamdeck, the limitless handheld experience
            "steamdeck" = nixpkgs-unstable.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs outputs system; };
                modules = [
                    home-manager-unstable.nixosModules.default
                    ./steamdeck/nixos
                    ./nixosmodules.nix
                    Jovian-NixOS.nixosModules.default
                ];
            };

            # NZC Game Community
            "nzc" = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs outputs system; };
                modules = [
                    home-manager.nixosModules.default
                    ./nzc/nixos/profiles/production
                    ./nixos/hardware/vm/qemu
                    ./nixosmodules.nix
                ];
            };

            # NZC Game Community, but hosted at home
            "nzc/selfhosted" = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs outputs system; };
                modules = [
                    home-manager.nixosModules.default
                    ./nzc/nixos/profiles/selfhosted
                    ./nixos/hardware/vm/qemu
                    ./nixosmodules.nix
                ];
            };

            # NZC Game Community, but for local development / testing
            "nzc/dev" = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs outputs system; };
                modules = [
                    home-manager.nixosModules.default
                    ./nzc/nixos/profiles/dev
                    ./nixos/hardware/vm/qemu
                    ./nixosmodules.nix
                ];
            };
        };
    };
}
