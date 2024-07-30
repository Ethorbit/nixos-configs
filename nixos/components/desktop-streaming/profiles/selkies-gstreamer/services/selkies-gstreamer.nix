{ config, lib, pkgs, ... }:

let
    entrypoint = pkgs.writeShellScriptBin "script" ''
    [ -s "$PASSWD_FILE" ] && export PASSWD=$(cat "$PASSWD_FILE") && export SELKIES_BASIC_AUTH_PASSWORD="$PASSWD"
    [ -s "$SELKIES_TURN_SHARED_SECRET_FILE" ] && export SELKIES_TURN_SHARED_SECRET=$(cat "$SELKIES_TURN_SHARED_SECRET_FILE")

    # Source environment for GStreamer
    # . /opt/gstreamer/gst-env
    . ${config.ethorbit.pkgs.python.selkies-gstreamer}/env

    # Set default display
    export DISPLAY="''${DISPLAY:-:0}"

    # Show debug logs for GStreamer
    export GST_DEBUG="''${GST_DEBUG:-*:2}"
    # Set password for basic authentication
    if [ "''${SELKIES_ENABLE_BASIC_AUTH,,}" = "true" ] && [ -z "''${SELKIES_BASIC_AUTH_PASSWORD}" ]; then export SELKIES_BASIC_AUTH_PASSWORD="''${PASSWD}"; fi

    # Wait for X11 to start
    echo "Waiting for X socket"
    until [ -S "/tmp/.X11-unix/X''${DISPLAY/:/}" ]; do sleep 1; done
    echo "X socket is ready"

    # Clear the cache registry
    rm -rf "''${HOME}/.cache/gstreamer-1.0"

    # Start the selkies-gstreamer WebRTC HTML5 remote desktop application
    ${config.ethorbit.pkgs.python.selkies-gstreamer}/bin/selkies-gstreamer $@
    '';
in
{
    config = {
        systemd.user.services."selkies-gstreamer" = {
            enable = true;
            description = "Systemd + nix port of nvidia-egl-docker's 'selkies-gstreamer' supervisor service, which is responsible for using selkies-gstreamer to stream the X server once it starts";
            environment = config.environment.variables;
            after = [ "network.target" "pulseaudio.service" ];
            requires = [ "pulseaudio.service" ];

            serviceConfig = {
                Type = "simple";
                Restart = "always";
                RestartSec = 5;
                CPUWeight = 500;
            };

            script = ''
            ${config.ethorbit.components.selkies-gstreamer.services.userValidationScript}/bin/script || exit 1
            ${pkgs.bash}/bin/bash -c "if [ ! $(echo ''${ENV_NOVNC_ENABLE} | ${pkgs.coreutils}/bin/tr '[:upper:]' '[:lower:]') ]; then ${entrypoint}/bin/script; else sleep infinity; fi"
            '';

            wantedBy = [ "default.target" ];
        };
    };
}
