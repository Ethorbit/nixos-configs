{ pkgs, ... }:

{

    environment.systemPackages = [ (pkgs.xorg.xorgserver.overrideAttrs (old: {
            patches = (old.patches or []) ++ [ ./patches/xephyr-custom-keybind.diff ];
        })
    )];

}
