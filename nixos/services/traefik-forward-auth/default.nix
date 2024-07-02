{ config, lib, ... }:

with lib;

let
    # Rename entry keys to be systemd service names.
    entries = listToAttrs (map (v: { name = "traefik-forward-auth@${v}"; value = config.ethorbit.services.traefik-forward-auth."${v}"; }) (attrNames config.ethorbit.services.traefik-forward-auth));
in {
    imports = [
        ../../packages/traefik-forward-auth
    ];

    options.ethorbit.services.traefik-forward-auth = (mkOption {
        description = "Configure traefik-forward-auth services";
        default = {
            enable = mkOption {
                type = types.bool;
                default = false;
            };
        };
        type = (types.attrsOf (types.submodule {
            options = {
                enable = mkOption {
                    type = types.bool;
                    description = "Whether or not the service is active";
                    default = false;
                    example = true;
                };

                user = mkOption {
                    type = types.str;
                    description = "The user who will run this service";
                    default = config.ethorbit.users.primary.username;
                    example = "bob";
                };

                environment = mkOption {
                    type = types.attrsOf types.str;
                    description = "Additional environment variables that the service will use";
                    default = {};
                    example = literalExpression ''
                        {
                            "PROVIDERS_GOOGLE_CLIENT_ID" = "your-client-id";
                            "PROVIDERS_GOOGLE_CLIENT_SECRET" = "your-client-secret";
                        }
                    '';
                };

                extraFlags = mkOption {
                    type = types.listOf types.str;
                    description = "List of flags to pass to the traefik-forward-auth process";
                    default = [ ];
                    example = literalExpression ''[ --providers.google.client-id=1234567890-abcd1234efgh5678ijkl90mnopqrst.apps.googleusercontent.com --port=4182 --lifetime=10300 ]'';
                };
            };
        }));
        example = literalExpression ''
            "my-forward-auth" = {
                enable = true;
                user = ${config.ethorbit.services.traefik-forward-auth.user.example};
                environment = ${config.ethorbit.services.traefik-forward-auth.environment.example};
                extraFlags = ${config.ethorbit.services.traefik-forward-auth.extraFlags.example};
            }
        '';
    });

    config = {
        systemd.services = (mapAttrs (name: data: {
            enable = data.enable;
            environment = data.environment;
            description = "Minimal forward authentication service that provides Google/OpenID oauth based login and authentication for the traefik reverse proxy";
            wants = [ "traefik.service" ];
            after = [ "network.target" "traefik.service" ];

            serviceConfig = {
                Type = "simple";
                User = data.user;
                Restart = "always";
                RestartSec = 5;
            };

            script = ''${config.ethorbit.pkgs.traefik-forward-auth}/bin/traefik-forward-auth ${toString data.extraFlags}'';

            wantedBy = [ "default.target" ];
        }) entries);
    };
}
