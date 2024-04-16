{ config, pkgs, lib, ... }:

{
    imports = [
        ../../../../nixos/components/display-server/profiles/xserver
        ../../../../nixos/components/desktop-environment/profiles/xfce
    ];

    # Can't use a display manager since it's incompatible with X nesting
    # We can just run the desktop executable as user, at boot.
    systemd.user.services."desktop" = {
        enable = true;
        environment = {
            DISPLAY = lib.mkForce ":${builtins.toString config.ethorbit.workstation.xorg.sessionNumbers.${config.ethorbit.users.primary.username}}";
            PATH = lib.mkForce "/run/wrappers/bin:/nix/profile/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin";
        };
        script = ''exec startxfce4'';
        wantedBy = [ "default.target" ];
    };

    services.xserver.displayManager.startx.enable = true;

    #services.xserver = {
        #videoDrivers = [ "dummy" ]; #"nvidia" ];
        #
        # Taken from docker-steam-headless's /templates xorg.dummy.conf
        #config = lib.mkForce ''
        #    Section "Device"
        #        Identifier      "Configured Video Device"
        #        Driver          "dummy"
        #        VideoRam        256000
        #    EndSection
        #
        #    Section "Monitor"
        #        Identifier      "Configured Monitor"
        #        HorizSync       5.0 - 1000.0
        #        VertRefresh     5.0 - 200.0
        #        ModeLine        "1920x1080" 148.50 1920 2448 2492 2640 1080 1084 1089 1125 +Hsync +Vsync
        #    EndSection
        #
        #    Section "Screen"
        #        Identifier      "Default Screen"
        #        Monitor         "Configured Monitor"
        #        Device          "Configured Video Device"
        #        DefaultDepth    24
        #        SubSection      "Display"
        #        Depth           24
        #        Modes           "1920x1080" "1280x800" "1024x768" "1920x1080" "1600x900" "1440x900"
        #        EndSubSection
        #    EndSection
        #'';
    #};
}
