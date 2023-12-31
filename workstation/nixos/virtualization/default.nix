{
    imports =
    [
        ./containers.nix
    ];
    
    virtualisation = {
        libvirtd = {
            enable = true;
            qemu.ovmf.enable = true;
            allowedBridges = [
                "virbr0"
                "br-wired"
            ];
        };
        
        podman = {
            enable = true;
            enableNvidia = true;
            dockerCompat = true;
            dockerSocket.enable = true;
        };
    };
}
