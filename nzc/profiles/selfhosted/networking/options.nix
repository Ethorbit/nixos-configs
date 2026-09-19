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
                    default = "6yo+x5Bg0pzypVO37zyjK1HI08xfvGa88Re9Pa2QWEI=";
                };

                ip = {
                    public = let
                        address = "40.160.142.205";
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
