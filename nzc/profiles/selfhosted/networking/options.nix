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
                    public = let
                        address = "158.69.214.109";
                    in {
                        address = mkOption {
                            type = types.str;
                            default = address;
                        };

                        addressCIDR = mkOption {
                            type = types.str;
                            default = "${address}/32";
                        };
                    };

                    private = let
                        address = "10.66.66.2";
                    in {
                        subnet = mkOption {
                            type = types.str;
                            default = "10.66.66.0/24";
                        };

                        address = mkOption {
                            type = types.str;
                            default = address;
                        };

                        addressCIDR = mkOption {
                            type = types.str;
                            default = "${address}/32";
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
