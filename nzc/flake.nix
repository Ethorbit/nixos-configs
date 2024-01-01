# TODO: install docker-compose version 2.18.1

{
    description = "NZC game community OS.";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
        agenix.url = "github:ryantm/agenix";
    };

    outputs = { self, nixpkgs, agenix, ... }: {
        nixosConfigurations."nzc" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./nixos/configuration.nix
                agenix.nixosModules.default
            ];
        };
    };
}
