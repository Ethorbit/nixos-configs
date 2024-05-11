{ config, pkgs, lib, ... }:

{
    imports = [
        ../../../../nixos/components/desktop-streaming/profiles/selkies-gstreamer
        ../../../../nixos/components/display-server/profiles/xserver
        ../../../../nixos/components/window-manager/profiles/i3
    ];

    # Can't use a display manager since it's incompatible with
    # these kind of setups. We can just run the desktop
    # executable as user, at boot.
    services.xserver.displayManager.startx.enable = true;

    #systemd.user.services."desktop" = {
    #    enable = true;
    #    environment = {
    #        DISPLAY = config.environment.variables.DISPLAY;
    #        PATH = lib.mkForce "/run/wrappers/bin:/nix/profile/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin";
    #    };
    #    script = ''${config.ethorbit.container.desktop.command}'';
    #    wantedBy = [ "default.target" ];
    #};
}
