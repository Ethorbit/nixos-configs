{ config, lib, pkgs, ... }:

{
    options.ethorbit.components.selkies-gstreamer = with lib; {
        settings = {
            user = mkOption {
                type = types.str;
                default = config.ethorbit.users.primary.username;
                example = "bob";
                description = "The nixos user selkies-gstreamer will run under, this will also be the same user that the desktop runs under.";
            };

            # You need to run a turn server somewhere and then set these up in your system.
            # This is needed to connect to WebRTC properly, which is what will provide you the graphical performance.
            # The alternative is just your average boring VNC
            turn = {
                host = mkOption {
                    type = types.str;
                    default = config.networking.hostName;
                    example = "turn.mywebsite";
                    description = "Host to connect to the TURN server";
                };

                port = mkOption {
                    type = types.int;
                    default = config.services.coturn.listening-port;
                    example = 3478;
                    description = "Port to connect to the TURN server";
                };

                protocol = mkOption {
                    type = types.str;
                    default = "udp";
                    example = "tcp";
                    description = "The protocol to communicate to the TURN server with. Either TCP or UDP.";
                };

                tls = mkOption {
                    type = types.bool;
                    default = (config.services.coturn.no-tls == false);
                    example = false;
                    description = "Whether or not the TURN server supports TLS.";
                };

                sharedSecret = mkOption {
                    type = types.nullOr types.str;
                    default = config.services.coturn.static-auth-secret;
                    example = "+xrjyydudpRMPvA6YKDmvXsB8X3dWc4YJPwutjy47i6XV1j74FfpuYLC+FbludYMo4DQ4cneCz4Kge44LHprEg==";
                    description = "String used to authenticate to the TURN server. Warning: this is world-readable and should only be used for testing. This is ignored if sharedSecretFile is used (which it should be).";
                };

                sharedSecretFile = mkOption {
                    type = types.nullOr types.str;
                    default = config.services.coturn.static-auth-secret-file;
                    example = "/etc/turn-shared-secret";
                    description = "File that stores the string used to authenticate to the TURN server";
                };
            };

            display = {
                number = mkOption {
                    type = types.int;
                    default = 0;
                    example = 1;
                    description = "The X display number";
                };
                
                port = mkOption {
                    type = types.int;
                    default = 8080;
                    example = 4200;
                    description = "The port to connect to the gstreamer display.";
                };

                useNOVNC = mkOption {
                    type = types.bool;
                    default = false;
                    example = true;
                    description = ''
                    There are two web interfaces that can be chosen in this container, the first being the default selkies-gstreamer WebRTC HTML5 interface (requires a TURN server or host networking), and the second being the fallback noVNC WebSocket HTML5 interface. While the noVNC interface does not support audio forwarding and remote cursors for gaming, it can be useful for troubleshooting the selkies-gstreamer WebRTC interface or usage in low bandwidth environments.
                    '';
                };

                webRTC = {
                    encoder = mkOption {
                        type = types.str;
                        default = "nvh264enc";
                        example = "x264enc";
                        description = ''
                        If you are using software fallback without allocated GPUs or your GPU is not listed as supporting H.264 (AVCHD), add the environment variable WEBRTC_ENCODER with the value x264enc, vp8enc, or vp9enc in your container configuration for falling back to software acceleration, which also has a very good performance depending on your CPU.
                        '';
                    };

                    enableResize = mkOption {
                        type = types.bool;
                        default = false;
                        example = true;
                        description = "";
                    };
                };

                colorDepth = mkOption {
                    type = types.int;
                    default = 24;
                };

                dpi = mkOption {
                    type = types.int;
                    default = 96;
                };

                refreshRate = mkOption {
                    type = types.int;
                    default = 60;
                };

                resolution = {
                    width = mkOption {
                        type = types.int;
                        default = 1920;
                        example = 2160;
                    };

                    height = mkOption {
                        type = types.int;
                        default = 1080;
                        example = 1440;
                    };
                };
            };

            auth = {
                password = mkOption {
                    type = types.str;
                    default = "mypasswd";
                    example = "somethinghopefullysecure";
                    description = "The password (in plaintext) that the client needs to enter in their browser to gain access to the desktop. Warning: this will be world-readable and should only be used for tests. This is ignored if passwordFile is used (and you should use it.)";
                };

                passwordFile = mkOption {
                    type = types.str;
                    default = "";
                    example = "/etc/selkies-gstreamer-pass";
                    description = "The file containing the password that the client needs to enter in their browser to gain access to the desktop.";
                };
            };
        };
    };
}
