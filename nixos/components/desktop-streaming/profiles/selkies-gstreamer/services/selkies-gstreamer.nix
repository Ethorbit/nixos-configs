{ config, lib, pkgs, ... }:

let
    entrypoint = pkgs.writeShellScriptBin "script" ''
    [ -s "$PASSWD_FILE" ] && export PASSWD=$(cat "$PASSWD_FILE") && export BASIC_AUTH_PASSWORD="$PASSWD"
    [ -s "$TURN_SHARED_SECRET_FILE" ] && export TURN_SHARED_SECRET=$(cat "$TURN_SHARED_SECRET_FILE")

    # Source environment for GStreamer
    # . /opt/gstreamer/gst-env
    . ${config.ethorbit.pkgs.python.selkies-gstreamer}/env

    # Set default display
    export DISPLAY="''${DISPLAY:-:0}"

    # Show debug logs for GStreamer
    export GST_DEBUG="''${GST_DEBUG:-*:2}"
    # Set password for basic authentication
    if [ "''${ENABLE_BASIC_AUTH,,}" = "true" ] && [ -z "''${BASIC_AUTH_PASSWORD}" ]; then export BASIC_AUTH_PASSWORD="''${PASSWD}"; fi

    # Wait for X11 to start
    echo "Waiting for X socket"
    until [ -S "/tmp/.X11-unix/X''${DISPLAY/:/}" ]; do sleep 1; done
    echo "X socket is ready"

    # Clear the cache registry
    rm -rf "''${HOME}/.cache/gstreamer-1.0"

    # Start the selkies-gstreamer WebRTC HTML5 remote desktop application
    ${config.ethorbit.pkgs.python.selkies-gstreamer}/bin/selkies-gstreamer \
        --addr="0.0.0.0" \
        --port="${builtins.toString config.ethorbit.components.selkies-gstreamer.settings.display.port}" \
        $@
    '';
in
{
    config = {
        systemd.services."selkies-gstreamer" = {
            enable = true;
            description = "Systemd + nix port of nvidia-egl-docker's 'selkies-gstreamer' supervisor service, which is responsible for using selkies-gstreamer to stream the X server once it starts.";
            environment = config.environment.variables;
            after = [ "network.target" ];

            serviceConfig = {
                User = config.ethorbit.components.selkies-gstreamer.settings.user;
                Type = "simple";
                Restart = "on-failure";
                RestartSec = 5;
            };

            script = ''
            ${pkgs.bash}/bin/bash -c "if [ ! $(echo ''${ENV_NOVNC_ENABLE} | ${pkgs.coreutils}/bin/tr '[:upper:]' '[:lower:]') ]; then ${entrypoint}/bin/script; else sleep infinity; fi"
            '';

            wantedBy = [ "default.target" ];
        };
    };
}
