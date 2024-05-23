{ config, ... }:

{
    age.secrets."workstation/host-and-containers/coturn-secret" = { file = ./secrets/coturn-secret.age; };
    environment.etc."coturn-secret" = {
        mode = "0600";
        source = config.age.secrets."workstation/host-and-containers/coturn-secret".path;
    };
}
