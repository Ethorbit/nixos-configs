{ config, lib, ... }:

{
    options.ethorbit.services.selkies-gstreamer = with lib; {
        enable = mkOption {
            type = types.bool;
            default = true;
        };
    };

    config = {

    };
}
