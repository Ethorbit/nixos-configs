{ config, ... }:

{
    imports = [
        # avahi is used by Sunshine to broadcast its presence to Moonlight clients
        ../../../service-discovery/profiles/avahi
        ./firewall-rules.nix
        ./packages.nix
    ];

    services.sunshine = {
        enable = true;
        autoStart = true;
        capSysAdmin = true;
    };

    # required to simulate input
    boot.kernelModules = [ "uinput" ];
    services.udev.extraRules = ''
        KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
    '';
}
