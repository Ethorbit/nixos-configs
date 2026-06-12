{ pkgs, ... }:

let
    xorgserver = if builtins.hasAttr "xorg-server" pkgs 
        then pkgs.xorg-server
        else if builtins.hasAttr "xorg" pkgs
        then pkgs.xorg.xorgserver
        else throw "No xorgserver found in pkgs";
in
{
    # Xephyr's default lock key sucks, I want it to make sense.
    environment.systemPackages = [ (xorgserver.overrideAttrs (old: {
            patches = (old.patches or []) ++ [ ./xephyr-custom-keybind.diff ];
        })
    )];
}
