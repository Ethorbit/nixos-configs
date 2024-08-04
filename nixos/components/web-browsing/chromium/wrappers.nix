# In order to use these, you need to create your own wrapper for your chromium package of choice, 
# add makeWrapper as an input, and then add the desired values inside your wrapper's postBuild...

{ config, lib, pkgs, ... }:

with lib;

{
    options.ethorbit.components.web-browsing.chromium.wrappers = {
        # Adds proper Video Encoding since it's disabled on Linux by default :/
        videoEncoding = mkOption {
            type = types.str;
            default = ''
                wrapProgram $out/bin/chromium \
                    --add-flags "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder"
            '';
        }; 
    };
}
