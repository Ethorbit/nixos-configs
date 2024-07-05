{ config, lib, ... }:

with lib;
let
    # Each container can generate their own Traefik dynamicConfigOptions
    # We will run each of their config creators and merge their results into one attr set.
    containerConfigOptions = (mkMerge (
        map (name: (
            config.ethorbit.workstation.containers.entries.${name}.traefikCreator name config.ethorbit.workstation.containers.entries.${name}
        )) (attrNames config.ethorbit.workstation.containers.entries)
    ));
in
{
    services.traefik = {
        enable = true;

        staticConfigOptions = {
            api.dashboard = false;
            #log.level = "DEBUG";

            # While this was intended as a reverse proxy for declarative nix containers
            # I will also give support for Docker containers, just in case
            providers.docker = {
                endpoint = "unix:///var/run/docker.sock";
                exposedbydefault = false;
            };

            entrypoints = {
                web.address = ":80";
                websecure.address = ":443";
            };
        };

        dynamicConfigOptions = mkMerge [ {
            http.services."authelia" = {
                loadBalancer.servers = [ { url = "http://127.0.0.1:9091"; } ];
            };

            http.routers."authelia" = {
                rule = "Host(`auth.${config.networking.hostName}.internal`)";
                entrypoints = "websecure";
                tls = true;
                service = "authelia";
            };

            http.middlewares = {
                "http-redirect" = {
                    redirectScheme = {
                       scheme = "http";
                       permanent = true;
                    };
                };

                "https-redirect" = {
                    redirectScheme = {
                       scheme = "https";
                       permanent = true;
                    };
                };

                "trailing-slash-redirect-http" = {
                    redirectRegex = {
                        permanent = true;
                        regex = "^http?://(.*)/(.+)";
                        replacement = "http://$1/$2/";
                    };
                };

                "trailing-slash-redirect-https" = {
                    redirectRegex = {
                        permanent = true;
                        regex = "^https?://(.*)/(.+)";
                        replacement = "https://$1/$2/";
                    };
                };
            };
        } containerConfigOptions ];
    };
}
