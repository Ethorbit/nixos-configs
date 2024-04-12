{ inputs, ... }:

{
    imports = with inputs; [
        ./nixos
        home-manager.nixosModules.default
        agenix.nixosModules.default
        flatpaks.nixosModules.default
        NixOS-WSL.nixosModules.wsl
    ];

    nixpkgs.overlays = [ inputs.nvidia-patch.overlays.default ];
}
