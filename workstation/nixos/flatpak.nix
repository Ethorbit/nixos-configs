{ config, ... }:

{
    imports = [
        ../../nixos/components/gaming/steam/profiles/flatpak
        ../../nixos/components/gaming/lutris/profiles/flatpak
    ];

    services.flatpak = {
        enable = true;
        #packages = [
            # Useful for accessing Windows VM(s?) or remote systems
            # maybe even GPU passthrough --> Windows --> GPU-PV --> multiple Windows guests w/ Sunshine
            # if only that setup didn't fucking crash Proxmox every ~5 minutes :(
            #{
            #    appId = "com.moonlight_stream.Moonlight";
            #    origin = "flathub";
            #}
        #];
    };
}
