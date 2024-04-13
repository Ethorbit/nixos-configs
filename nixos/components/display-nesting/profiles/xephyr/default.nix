{ config, pkgs, ... }:

{
    # Xephyr's default lock key sucks, I want it to make sense.
    environment.systemPackages = [ (pkgs.xorg.xorgserver.overrideAttrs (old: {
            patches = (old.patches or []) ++ [ ./xephyr-custom-keybind.diff ];
        })
    )];
}
