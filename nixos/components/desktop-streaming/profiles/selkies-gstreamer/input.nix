{ config, pkgs, ... }:

{
    i18n.inputMethod = {
        enabled = "fcitx5";
        fcitx5.addons = with pkgs; [
            fcitx5-mozc
            fcitx5-gtk
        ];
    };

    # Configure joystick interposer
    #
    # NOTE: this DOES NOT work and I cannot for the life of me get it to work.
    # So if you really do need joystick support, you are going to need to figure out how to create these yourself.
    systemd.tmpfiles.rules = [
        "c /dev/input/js0 0660 root input - 13:64"
        "c /dev/input/js1 0660 root input - 13:65"
        "c /dev/input/js2 0660 root input - 13:66"
        "c /dev/input/js3 0660 root input - 13:67"
    ];
    #system.activationScripts."joystick-input" = ''
    #    ${pkgs.coreutils}/bin/mknod -m 0660 /dev/input/js0 c 13 64
    #    ${pkgs.coreutils}/bin/mknod -m 0660 /dev/input/js1 c 13 65
    #    ${pkgs.coreutils}/bin/mknod -m 0660 /dev/input/js2 c 13 66
    #    ${pkgs.coreutils}/bin/mknod -m 0660 /dev/input/js3 c 13 67
    #    chown root:input /dev/input/js0 /dev/input/js1 /dev/input/js2 /dev/input/js3
    #'';
}
