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
                publicKey = mkOption {
                    type = types.str;
                    default = "akMpPacpgqdNhWboReNmDwnGgLIwRt70cdnV1Ra31i4=";
                };

                ip = {
                    public = mkOption {
                        type = types.str;
                        default = "158.69.214.109";
                    };

                    private = {
                        subnet = mkOption {
                            type = types.str;
                            default = "10.66.66.0/24";
                        };

                        address = mkOption {
                            type = types.str;
                            default = "10.66.66.2";
                        };

                        addressCIDR = mkOption {
                            type = types.str;
                            default = "10.66.66.2/32";
                        };
                    };
                };

                port = mkOption {
                    type = types.str;
                    default = "57561";
                };

                gateway = mkOption {
                    type = types.str;
                    default = "10.66.66.1";
                };  
            };
        };
    };
}
