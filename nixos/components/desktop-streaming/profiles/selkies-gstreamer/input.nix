{ config, pkgs, ... }:

{
    i18n.inputMethod = {
        enabled = "fcitx5";
        fcitx5.addons = with pkgs; [
            fcitx5-mozc
            fcitx5-gtk
        ];
    };

    systemd.tmpfiles.rules = [
        "d /dev/input 0755"
        "f /dev/input/js0"
        "f /dev/input/js1"
        "f /dev/input/js2"
        "f /dev/input/js3"
    ];
}
