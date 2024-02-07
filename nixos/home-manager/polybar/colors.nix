{ config, lib, ... }:

{
    options = with lib; {
        ethorbit.polybar.colors = {
            background = lib.mkOption {
                type = types.str;
                default = "#aa500";
            };
            
            background-alt = lib.mkOption {
                type = types.str;
                default = "#444";
            };

            foreground = lib.mkOption {
                type = types.str;
                default = "#dfdfdf";
            };

            foreground-alt = lib.mkOption {
                type = types.str;
                default = "#555";
            };
 
            primary = lib.mkOption {
                type = types.str;
                default = "#ffb52a";
            };
 
            secondary = lib.mkOption {
                type = types.str;
                default = "#e60053";
            };
 
            alert = lib.mkOption {
                type = types.str;
                default = "#bd2c40";
            };
        };
    };
}
