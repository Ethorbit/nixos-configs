{ config, lib, makeEntry, ... }:

let
    # This will allow clients outside host network to be able to connect to the desktops.
    # https://container.<container name>.<hostname>.internal
    # clients must have *.<hostname>.internal route to host's public IP for connection to work
    traefikCreator = name: entry: {
        http = {
            # We enforce HTTPS since it is required for some interface
            # features, such as the clipboard sharing.
            routers."${name}-http" = {
                rule = "Host(`container.${name}.${config.networking.hostName}.internal`)";
                service = "${name}";
                entrypoints = "web";
                middlewares = [ "https-redirect" ];
            };

            routers."${name}-https" = {
                rule = "Host(`container.${name}.${config.networking.hostName}.internal`)";
                tls = true;
                service = "${name}";
                entrypoints = "websecure";
            };

            services = {
                "${name}" = {
                    loadBalancer = {
                        servers = [
                            {
                                url = "http://${entry.ip}:8080/";
                            }
                        ];
                    };
                };
            };
        };
    };
in
{
    ethorbit.workstation.containers.entries."development" = (makeEntry {
        inherit traefikCreator;
        ip = "172.16.1.220";
        imports = [ ./config ./development ];
        # To allow Docker to work
        extraFlags = [
            "--system-call-filter=add_key"
            "--system-call-filter=keyctl"
            "--system-call-filter=bpf"
        ];
    });
}
