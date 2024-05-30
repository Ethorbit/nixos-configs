{ config, lib, ... }:

{
    # Reverse proxy for container web services to be reachable by the outside.
    # By default, /container/name will always go to the container's 8080 port.
    services.traefik = {
        enable = true;

        staticConfigOptions = {
            api.dashboard = false;

            # While this was intended as a reverse proxy for declarative nix containers
            # I will also give support for Docker containers, just in case
            providers.docker = {
                endpoint = "unix:///var/run/docker.sock";
                exposedbydefault = false;
            };

            entrypoints = {
                websecure.address = ":443";
                web = {
                    address = ":80";
                    http.redirections.entryPoint = {
                        to = "websecure";
                        scheme = "https";
                        permanent = true;
                    };
                };
            };
        };

        dynamicConfigOptions = with lib; {
            http.routers = mapAttrs (name: data: {
                service = name;
                tls = true;
                entrypoints = "websecure";
                rule = "Path(`/container/${name}`)";
            }) config.ethorbit.workstation.containers;

            http.services = mapAttrs (name: data: {
                loadBalancer = {
                    servers = [
                        {
                            url = "http://${data.ip}:8080";
                        }
                    ];
                };
            }) config.ethorbit.workstation.containers;
        };
    };
}
