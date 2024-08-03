# Chromium-based browsers won't have working graphics (and might crash) when they are using VirtualGL libraries
# Just wrap the Chromium binary and remove the library paths; Chromium will still use the GPU

{ config, pkgs, ... }:

with pkgs;

{
    environment.systemPackages = [
        (symlinkJoin {
            name = "chromium-wrapped";
            paths = [
                chromium
            ];
            buildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
                wrapProgram $out/bin/chromium --unset LD_PRELOAD
            '';
        })
    ];
}
