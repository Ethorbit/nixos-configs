{ config, lib, makeEntry, ... }:

let
    # This will allow clients outside host to be able to connect to the desktops.
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
    ethorbit.workstation.containers.entries = {
        "programming" = (makeEntry {
            inherit traefikCreator;
            #ephemeral = true;
            ip = "172.16.1.220";
            imports = [
                ./shared/selkies-gstreamer
                # To allow Flatpak to work
                ./shared/bubblewrap-fix
                ./shared/browsing
                ./programming
            ];
            # To allow Docker to work
            extraFlags = [
                "--system-call-filter=add_key"
                "--system-call-filter=keyctl"
                "--system-call-filter=bpf"
            ];
        });

        #"videoediting" = (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.221";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/browsing
        #        ./videoediting
        #    ];
        #});

        #"imageediting" = (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.222";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/browsing
        #        ./imageediting
        #    ];
        #});

        #"modelling" = (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.223";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/browsing
        #        ./modelling
        #    ];
        #});

        #"music" = (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.224";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/browsing
        #        ./music
        #    ];
        #});

        #"socials" = (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.225";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/browsing
        #        ./socials
        #    ];
        #});

        #"finance" = (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.226";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/browsing
        #        ./finance
        #    ];
        #});

        # Should not be used directly, has a web panel.
        #"stablediffusion" = (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.227";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./stablediffusion
        #    ];
        #});
    };
}
