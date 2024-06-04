{ config, lib, makeEntry, ... }:

let
    # This will allow clients outside host network to be able to connect to the desktops.
    # https://<host>/container/<name>
    traefikCreator = name: entry: {
        http = {
            # The web app listens on the trailing slash, so it is
            # important to enforce it, or else the content won't load
            #
            # We also enforce HTTPS since it is required for some interface
            # features, such as the clipboard sharing.
            routers."${name}-http-no-trailing-slash" = {
                rule = "PathPrefix(`/container/${name}`)";
                service = "${name}";
                entrypoints = "web";
                middlewares = [ "trailing-slash-redirect-http" "https-redirect" ];
            };

            routers."${name}-https-no-trailing-slash" = {
                rule = "PathPrefix(`/container/${name}`)";
                tls = true;
                service = "${name}";
                entrypoints = "websecure";
                middlewares = [ "trailing-slash-redirect-https" ];
            };

            routers."${name}-http" = {
                rule = "PathPrefix(`/container/${name}/`)";
                service = "${name}";
                entrypoints = "web";
                middlewares = [ "https-redirect" ];
            };

            routers."${name}-https" = {
                rule = "PathPrefix(`/container/${name}/`)";
                tls = true;
                service = "${name}";
                entrypoints = "websecure";
                middlewares = [ "${name}-strip-prefix" ];
            };

            services."${name}" = {
                loadBalancer = {
                    #passHostHeader = false;
                    servers = [
                        {
                            url = "http://${entry.ip}:8080";
                        }
                    ];
                };
            };

            middlewares = {
                "${name}-strip-prefix" = {
                    stripPrefix.prefixes = "/container/${name}/";
                };
            };
        };
    };
in
{
    ethorbit.workstation.containers.entries."development" = (makeEntry {
        inherit traefikCreator;
        ip = "172.12.1.220";
        label = "selkies-gstreamer";
        imports = [ ./config ./development ];
        # To allow Docker to work
        extraFlags = [
            "--system-call-filter=add_key"
            "--system-call-filter=keyctl"
            "--system-call-filter=bpf"
        ];
    });
}
