{ config, lib, ... }:

{
    options = with lib; {
        ethorbit.nzc.network.sshd.port = mkOption {
            type = types.str;
            default = "2222";
        };
    };

    config = with lib; {
        services.openssh = {
            enable = true;
            ports = [ (strings.toInt "${config.ethorbit.nzc.network.sshd.port}") ];
            settings = {
                PasswordAuthentication = false;
                PermitRootLogin = "no";
            };
        };
    };
}
