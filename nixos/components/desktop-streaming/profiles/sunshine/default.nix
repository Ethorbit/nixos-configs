{ config, ... }:

{
    imports = [
        ../../../../services/sunshine
        # avahi is used by Sunshine to broadcast its presence to Moonlight clients
        ../../../service-discovery/profiles/avahi
        ./security-wrapper.nix
        ./firewall-rules.nix
        ./packages.nix
    ];

    # required to simulate input
    boot.kernelModules = [ "uinput" ];
    services.udev.extraRules = ''
        #KERNEL==“uinput”, SUBSYSTEM==“misc”, OPTIONS+=“static_node=uinput”, TAG+=“uaccess”
        
        # other attempt
        KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
    '';
}
