{ config, ... }:

{
    imports = [
        ./nixpkgs
        ./options.nix
        ./packages.nix
        ./environment.nix
        ./home-manager
        ./services
    ];

    time.timeZone = "America/Los_Angeles";

    age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    nix.settings = {
        auto-optimise-store = true;
    };

    nix.extraOptions = ''
        experimental-features = nix-command flakes
    '';
}
