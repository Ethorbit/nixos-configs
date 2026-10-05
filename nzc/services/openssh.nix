{ config, lib, ... }:

{
    options = with lib; {
        ethorbit.nzc.network.sshd.port = mkOption {
            type = types.int;
            default = 2222;
        };
    };

    config = {
        services.openssh = {
            enable = true;
            ports = [ config.ethorbit.nzc.network.sshd.port ];
            settings = {
                PasswordAuthentication = false;
                PermitRootLogin = "no";
            };
        };
    };
}
