{ config, lib, ... }:

{
    imports = [
        ../../packages/traefik-forward-auth
    ];

    options.ethorbit.services.traefik-forward-auth = with lib; {
        enable = mkOption {
            type = types.bool;
            default = true;
            example = false;
        };

        user = mkOption {
            type = types.str;
            description = "The user who will run traefik-forward-auth";
            default = config.ethorbit.users.primary.username;
            example = "bob";
        };

        extraFlags = mkOption {
            type = types.listOf types.str;
            description = "List of flags to pass to traefik-forward-auth";
            default = [ ];
            example = literalExpression ''[ --providers.google.client-id=1234567890-abcd1234efgh5678ijkl90mnopqrst.apps.googleusercontent.com --port=4182 --lifetime=10300 ]'';
        };
    };

    config = {
        systemd.services."traefik-forward-auth" = {
            enable = config.ethorbit.services.traefik-forward-auth.enable;
            description = "Minimal forward authentication service that provides Google/OpenID oauth based login and authentication for the traefik reverse proxy";
            wants = [ "traefik.service" ];
            after = [ "network.target" "traefik.service" ];

            serviceConfig = {
                Type = "simple";
                User = config.ethorbit.services.traefik-forward-auth.user;
                Restart = "always";
                RestartSec = 5;
            };

            script = ''${config.ethorbit.pkgs.traefik-forward-auth}/bin/traefik-forward-auth ${toString config.ethorbit.services.traefik-forward-auth.extraFlags}'';

            wantedBy = [ "default.target" ];
        };
    };
}
