{ config, lib, ... }:

with lib;

{
    options = {
        ethorbit.components.web-browsing.brave.wrappers = {
            # Adds proper Video Encoding since it's disabled on Linux by default :/
            videoEncoding = mkOption {
                type = types.str;
                default = ''
                    wrapProgram $out/bin/brave \
                        --add-flags "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder"
                '';
            }; 
        };
    };
}
