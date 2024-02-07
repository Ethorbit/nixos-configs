{ config, lib, ... }:

{
    options = with lib; {
        ethorbit.polybar.style = {
            radius = lib.mkOption {
                type = types.str;
                default = "0.0";
            };
        };
    };
}
