{ lib, ... }:

{
    options = with lib; {
        ethorbit.nzc.network = {
            ethernet = {
                ip = mkOption {
                    type = types.str;
                    default = "192.168.254.225";
                };

                gateway = mkOption {
                    type = types.str;
                    default = "192.168.254.254";
                };
            };

            vpn = {
                ip = {
                    public = mkOption {
                        type = types.str;
                        default = "158.69.214.109";
                    };

                    private = mkOption {
                        type = types.str;
                        default = "10.66.66.2";
                    };

                    privateCIDR = mkOption {
                        type = types.str;
                        default = "10.66.66.2/32";
                    };
                };

                port = mkOption {
                    type = types.str;
                    default = "51117";
                };

                gateway = mkOption {
                    type = types.str;
                    default = "10.66.66.1";
                };  
            };
        };
    };
}
