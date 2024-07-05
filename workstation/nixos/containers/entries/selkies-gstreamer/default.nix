{ config, lib, makeEntry, ... }:

let
    defaults = {
        # Recommended. Selkies Gstreamer's password prompt alone is not enough for securing a remote desktop.
        twoFactor = true;
    };

    # This will allow clients outside host to be able to connect to the desktops.
    # https://container-<container name>.<hostname>.internal
    # clients must have *.<hostname>.internal route to host's public IP for connections to work.
    traefikCreator = name: entry: {
        http = let
            container-host = "container-${name}.${config.networking.hostName}.internal";
        in {
            middlewares = lib.mkIf (entry.twoFactor) {
                "authelia-${name}" = {
                    forwardauth = {
                        address = "http://${config.services.authelia.instances."system".settings.server.host}:${toString config.services.authelia.instances."system".settings.server.port}/api/verify?rd=https://auth.${config.networking.hostName}.internal/%23/";
                        trustforwardheader = true;
                        authresponseheaders = "Remote-User,Remote-Groups,Remote-Name,Remote-Email";
                    };
                };
            };

            # We enforce HTTPS since it is required for some interface
            # features, such as the clipboard sharing.
            routers."${name}-http" = {
                rule = "Host(`${container-host}`)";
                service = "${name}";
                entrypoints = "web";
                middlewares = [ "https-redirect" ];
            };

            routers."${name}-https" = {
                rule = "Host(`${container-host}`)";
                tls = true;
                service = "${name}";
                entrypoints = "websecure";
                middlewares = lib.mkIf (entry.twoFactor) [ "authelia-${name}" ];
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
        "programming" = defaults // (makeEntry {
            inherit traefikCreator;
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

        #"videoediting" = defaults // (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.221";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/browsing
        #        ./videoediting
        #    ];
        #});

        #"audioediting" = defaults // (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.222";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/browsing
        #        ./videoediting
        #    ];
        #});

        #"imageediting" = defaults // (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.223";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/browsing
        #        ./imageediting
        #    ];
        #});

        #"modelling" = defaults // (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.224";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/browsing
        #        ./modelling
        #    ];
        #});

        #"music" = defaults // (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.225";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/browsing
        #        ./music
        #    ];
        #});

        #"socials" = defaults // (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.226";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/browsing
        #        ./socials
        #    ];
        #});

        #"finance" = defaults // (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.227";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/browsing
        #        ./finance
        #    ];
        #});

        # Should not be used directly, has a web panel.
        #"stablediffusion" = defaults // (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.228";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./stablediffusion
        #    ];
        #});
    };
}
