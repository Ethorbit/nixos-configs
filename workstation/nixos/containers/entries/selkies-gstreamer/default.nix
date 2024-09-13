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
in
{
    # Containers aren't used currently because the GPU only works for OpenGL applications.
    # Many applications use Vulkan and will run very badly.. I've decided this is more trouble than 
    # it's worth and will run everything on the host until a better alternative to VirtualGL is found.

    # Hopefully a vGPU solution that is free and supports all modern GPUs is created one day..
    # vGPUs should be the future because then you could split your GPU up between VIRTUAL MACHINES

    ethorbit.workstation.containers.entries = {
        #"programming" = defaults // (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.220";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/flatpak
        #        ./shared/browsing
        #        ./shared/media
        #        ./programming
        #    ];
        #    bindMounts = {
        #        "/mnt/storage/Projects".isReadOnly = false;
        #        "/mnt/storage/Servers".isReadOnly = false;
        #        "/mnt/storage/Downloads/programming".isReadOnly = false;
        #        "/mnt/storage/Documents/programming".isReadOnly = false;
        #        "/mnt/storage/Videos/programming".isReadOnly = false;
        #    };
        #    extraFlags = [
        #        # To allow Docker to work
        #        "--system-call-filter=add_key"
        #        "--system-call-filter=keyctl"
        #        "--system-call-filter=bpf"
        #    ];
        #});

        #"gaming" = defaults // (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.221";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/flatpak
        #        ./shared/browsing
        #        ./gaming
        #    ];
        #    bindMounts = {
        #        "/mnt/storage/SteamLibrary".isReadOnly = false;
        #        "/mnt/storage/Pictures/gaming".isReadOnly = false;
        #        "/mnt/storage/Videos/gaming".isReadOnly = false;
        #        "/mnt/storage/Downloads/gaming".isReadOnly = false;
        #    };
        #});

        #"videoediting" = defaults // (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.222";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/network_mounts/videos
        #        ./shared/media
        #        ./shared/browsing
        #        ./videoediting
        #    ];
        #    bindMounts = {
        #        "/mnt/storage/Videos/videoediting".isReadOnly = false;
        #        "/mnt/storage/Audio/audioediting".isReadOnly = true;
        #        "/mnt/storage/Pictures/imageediting".isReadOnly = true;
        #    };
        #});

        #"audioediting" = defaults // (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.223";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/network_mounts/videos
        #        ./shared/media
        #        ./shared/browsing
        #        ./audioediting
        #    ];
        #    bindMounts = {
        #        "/mnt/storage/Music/audioediting".isReadOnly = false;
        #        "/mnt/storage/Audio/audioediting".isReadOnly = false;
        #        "/mnt/storage/Videos/videoediting".isReadOnly = true;
        #    };
        #});

        #"imageediting" = defaults // (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.224";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/browsing
        #        ./imageediting
        #    ];
        #    bindMounts = {
        #        "/mnt/storage/Downloads/imageediting".isReadOnly = false;
        #        "/mnt/storage/Pictures/imageediting".isReadOnly = false;
        #    };
        #});

        #"modelling" = defaults // (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.225";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/browsing
        #        ./modelling
        #    ];
        #    bindMounts = {
        #        "/mnt/storage/Documents/modelling".isReadOnly = false;
        #        "/mnt/storage/Downloads/modelling".isReadOnly = false;
        #    };
        #});

        #"musicplayer" = defaults // (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.226";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/media
        #        ./shared/browsing
        #        ./musicplayer
        #    ];
        #    systemdService.serviceConfig = {
        #        CPUWeight = 50;
        #        MemoryMax = "10%";
        #        CPUQuota = "150%";
        #    };
        #    bindMounts = {
        #        "/mnt/storage/Music".isReadOnly = false;
        #        "/mnt/storage/Downloads/music".isReadOnly = false;
        #    };
        #});

        #"socials" = defaults // (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.227";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/network_mounts/videos
        #        ./shared/browsing
        #        ./socials
        #    ];
        #    bindMounts = {
        #        "/mnt/storage/Videos/socials".isReadOnly = false;
        #        "/mnt/storage/Pictures/socials".isReadOnly = false;
        #        "/mnt/storage/Downloads/socials".isReadOnly = false;
        #    };
        #});

        #"finance" = defaults // (makeEntry {
        #    inherit traefikCreator;
        #    ip = "172.16.1.228";
        #    imports = [
        #        ./shared/selkies-gstreamer
        #        ./shared/browsing
        #        ./finance
        #    ];
        #    systemdService.serviceConfig = {
        #        CPUWeight = 50;
        #        MemoryMax = "10%";
        #        CPUQuota = "150%";
        #    };
        #    bindMounts = {
        #        "/mnt/storage/Videos/finance".isReadOnly = false;
        #        "/mnt/storage/Documents/finance".isReadOnly = false;
        #        "/mnt/storage/Downloads/finance".isReadOnly = false;
        #    };
        #});

        ## Should not be used directly, has a web panel.
        ##"stablediffusion" = defaults // (makeEntry {
        ##    inherit traefikCreator;
        ##    ip = "172.16.1.229";
        ##    imports = [
        ##        ./shared/selkies-gstreamer
        ##        ./stablediffusion
        ##    ];
        ##});
    };
}
