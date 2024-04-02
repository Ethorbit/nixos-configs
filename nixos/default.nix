{ config, ... }:

{
    imports = [
        ./nixpkgs
        ./options.nix
        ./packages.nix
        ./environment.nix
        ./timezone.nix
        ./home-manager
        ./services
        ./udev-rules.nix
        ./networking.nix
    ];

    age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    programs.ssh.askPassword = "";
    programs.nano.enable = false;

    nix.settings = {
        auto-optimise-store = true;
    };

    nix.extraOptions = ''
        experimental-features = nix-command flakes
    '';
}
