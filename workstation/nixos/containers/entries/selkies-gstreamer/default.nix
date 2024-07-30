# Adjust the systemd resources. Each Selkies Gstreamer instance can use almost a FULL CPU core of usage (~80-100%)
# Allowing multiple selkies instances to run on the same CPU core will result in heavy interface lag.

{ config, lib, makeEntry, ... }:

let
    defaults = {
        # Recommended. Selkies Gstreamer's password prompt alone is not enough for securing a remote desktop.
        # Note: this only applies for people connecting outside of the host, connections from the host do not go through 2FA.
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

    defaultSystemdService.serviceConfig = {
        # Systemd defaults to 100 for weights. We set it lower, so that 
        # the host gets the highest priority on ITS processes 
        # running with default weights.
        #
        # If you connect to containers from the host's browser, the difference
        # in performance from this is noticeable. With all default weights,
        # the interface and audio freezes and lags as the containers compete with the host
        # for CPU usage. That is why we want to keep containers at a lower priority.
        CPUWeight = 50;
        IOWeight = 80;
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
                ./shared/media
                ./programming
            ];
            bindMounts = {
                "/mnt/storage/Projects".isReadOnly = false;
                "/mnt/storage/Servers".isReadOnly = false;
                "/mnt/storage/Downloads/programming".isReadOnly = false;
                "/mnt/storage/Documents/programming".isReadOnly = false;
                "/mnt/storage/Videos/programming".isReadOnly = false;
            };
            systemdService = defaultSystemdService // { serviceConfig = {
                CPUWeight = 70;
            }; };
            extraFlags = [
                # To allow Docker to work
                "--system-call-filter=add_key"
                "--system-call-filter=keyctl"
                "--system-call-filter=bpf"
            ];
        });

        "videoediting" = defaults // (makeEntry {
            inherit traefikCreator;
            ip = "172.16.1.221";
            imports = [
                ./shared/selkies-gstreamer
                ./shared/network_mounts/videos
                ./shared/media
                ./shared/browsing
                ./videoediting
            ];
            bindMounts = {
                "/mnt/storage/Videos/videoediting".isReadOnly = false;
                "/mnt/storage/Audio/audioediting".isReadOnly = true;
                "/mnt/storage/Pictures/imageediting".isReadOnly = true;
            };
            systemdService = defaultSystemdService;
        });

        "audioediting" = defaults // (makeEntry {
            inherit traefikCreator;
            ip = "172.16.1.222";
            imports = [
                ./shared/selkies-gstreamer
                ./shared/network_mounts/videos
                ./shared/media
                ./shared/browsing
                ./audioediting
            ];
            bindMounts = {
                "/mnt/storage/Music/audioediting".isReadOnly = false;
                "/mnt/storage/Audio/audioediting".isReadOnly = false;
                "/mnt/storage/Videos/videoediting".isReadOnly = true;
            };
            systemdService = defaultSystemdService;
        });

        "imageediting" = defaults // (makeEntry {
            inherit traefikCreator;
            ip = "172.16.1.223";
            imports = [
                ./shared/selkies-gstreamer
                ./shared/browsing
                ./imageediting
            ];
            bindMounts = {
                "/mnt/storage/Downloads/imageediting".isReadOnly = false;
                "/mnt/storage/Pictures/imageediting".isReadOnly = false;
            };
            systemdService = defaultSystemdService;
        });

        "modelling" = defaults // (makeEntry {
            inherit traefikCreator;
            ip = "172.16.1.224";
            imports = [
                ./shared/selkies-gstreamer
                ./shared/browsing
                ./modelling
            ];
            bindMounts = {
                "/mnt/storage/Documents/modelling".isReadOnly = false;
                "/mnt/storage/Downloads/modelling".isReadOnly = false;
            };
            systemdService = defaultSystemdService;
        });

        "musicplayer" = defaults // (makeEntry {
            inherit traefikCreator;
            ip = "172.16.1.225";
            imports = [
                ./shared/selkies-gstreamer
                ./shared/media
                ./shared/browsing
                ./musicplayer
            ];
            bindMounts = {
                "/mnt/storage/Music".isReadOnly = false;
                "/mnt/storage/Downloads/music".isReadOnly = false;
            };
            systemdService = defaultSystemdService // { serviceConfig = {
                CPUWeight = 20;
                IOWeight = 20;
            }; };
        });

        "socials" = defaults // (makeEntry {
            inherit traefikCreator;
            ip = "172.16.1.226";
            imports = [
                ./shared/selkies-gstreamer
                ./shared/network_mounts/videos
                ./shared/browsing
                ./socials
            ];
            bindMounts = {
                "/mnt/storage/Videos/socials".isReadOnly = false;
                "/mnt/storage/Pictures/socials".isReadOnly = false;
                "/mnt/storage/Downloads/socials".isReadOnly = false;
            };
            systemdService = defaultSystemdService; 
        });

        "finance" = defaults // (makeEntry {
            inherit traefikCreator;
            ip = "172.16.1.227";
            imports = [
                ./shared/selkies-gstreamer
                ./shared/browsing
                ./finance
            ];
            bindMounts = {
                "/mnt/storage/Videos/finance".isReadOnly = false;
                "/mnt/storage/Documents/finance".isReadOnly = false;
                "/mnt/storage/Downloads/finance".isReadOnly = false;
            };
            systemdService = defaultSystemdService // { serviceConfig = {
                CPUWeight = 20;
                IOWeight = 20;
            }; };
        });

        # Should not be used directly, has a web panel.
        #"stablediffusion" = defaults // (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.228";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./stablediffusion
        #    ];
        #    systemdService = defaultSystemdService;
        #});
    };
}
