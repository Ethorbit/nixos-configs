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
            buildInputs = [ makeWrapper ];
            postBuild = ''
                ${config.ethorbit.components.web-browsing.chromium.wrappers.videoEncoding}
                # GPU compositing causes slowness / lower framerate \o/
                wrapProgram $out/bin/chromium \
                    --unset LD_PRELOAD \
                    --add-flags "--disable-gpu-compositing"
            '';
        })
    ];
}
