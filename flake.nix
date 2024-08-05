{
    description = "Ethorbit's NixOS Systems";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        nixpkgs-old.url = "github:nixos/nixpkgs/nixos-23.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        agenix.url = "github:ryantm/agenix";
        flatpaks.url = "github:GermanBread/declarative-flatpak/stable";

        nvidia-patch = {
            url = "github:icewind1991/nvidia-patch-nixos";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        NixOS-WSL = {
            url = "github:nix-community/NixOS-WSL";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { 
        self,
        nixpkgs,
        nixpkgs-old,
        nixpkgs-unstable,
        home-manager,
        agenix,
        flatpaks,
        nvidia-patch,
        NixOS-WSL
    } @inputs: let
        inherit (self) outputs;
        system = "x86_64-linux";
    in {
        nixosConfigurations = {
            # Home NAS, the centralized source of storage.
            "homenas" = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs outputs system; };
                modules = [
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
                    ./nixos/components/programming/ide/profiles/standalone/profiles/cli
                    ./nixos/hardware/container/wsl
                    ./nixosmodules.nix
                ];
            };
            "ide/desktop" = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs outputs system; };
                modules = [
                    ./nixos/components/programming/ide/profiles/standalone/profiles/desktop
                    ./nixos/hardware/vm/qemu
                    ./nixosmodules.nix
                ];
            };

            # SUS!
            "exploit" = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs outputs system; };
                modules = [
                    ./exploit/nixos
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
                    ./headless-nvidia/nixos
                    ./nixosmodules.nix
                ];
            };

            # Workstation OS, the powerhouse of all productivity.
            "workstation" = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs outputs system; };
                modules = [
                    ./workstation/nixos
                    ./nixosmodules.nix
                ];
            };

            # NZC Game Community
            "nzc" = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs outputs system; };
                modules = [
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
                    ./nzc/nixos/profiles/dev
                    ./nixos/hardware/vm/qemu
                    ./nixosmodules.nix
                ];
            };
        };
    };
}
