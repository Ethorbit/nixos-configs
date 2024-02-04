{ config, ... }:

{
    imports = [
        ./options.nix
        ./packages.nix
        ./home-manager
    ];

    age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    nix.settings = {
        auto-optimise-store = true;
    };

    nix.extraOptions = ''
        experimental-features = nix-command flakes
    '';
}
