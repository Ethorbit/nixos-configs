{ config, lib, ... }:

with lib;
let
    selkies-gstreamer-containers = (filterAttrs (name: value: value.label == "selkies-gstreamer") config.ethorbit.workstation.containers.entries);
in
{
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
            }) selkies-gstreamer-containers;

            http.services = mapAttrs (name: data: {
                loadBalancer = {
                    servers = [
                        {
                            url = "http://${data.ip}:8080";
                        }
                    ];
                };
            }) selkies-gstreamer-containers;
        };
    };
}
