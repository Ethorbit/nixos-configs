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
    };
}
