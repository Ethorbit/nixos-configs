{ config, pkgs, ... }:

let
    sessionScript = pkgs.writeShellScriptBin "script" ''
        ${config.services.xserver.displayManager.sessionCommands}
    '';
in
{
    systemd.user.services."virtual-desktop" = {
        enable = true;
        description = "Systemd + nix port of nvidia-egl-docker's 'entrypoint' supervisor service, the part that starts the desktop";
        environment = config.environment.variables;
        requires = [ "virtual-xserver.service" ];
        wants = [ "graphical-session-pre.target" "graphical-session.target" ];
        before = [ "graphical-session.target" ];
        after = [ "dbus.service" "graphical-session-pre.target" "virtual-xserver.service" ];
        partOf = [ "graphical-session.target" ];

        serviceConfig = {
            Type = "simple";
            Restart = "always";
            RestartSec = 5;
            CPUWeight = 500;
        };

        script = ''
        "${config.ethorbit.components.selkies-gstreamer.services.userValidationScript}/bin/script" || exit 0
        source /etc/profile

        # This fixes applications not utilizing OpenGL. Not sure of a NIX way to fix this.
        export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/run/opengl-driver/lib"

        # Wait for X11 to start
        echo "Waiting for X socket"
        until [ -S "/tmp/.X11-unix/X''${DISPLAY/:/}" ]; do sleep 1; done
        echo "X socket is ready"

        # Resize the screen to the provided size
        ${config.ethorbit.pkgs.python.selkies-gstreamer}/bin/selkies-gstreamer-resize ''${DISPLAY_SIZEW}x''${DISPLAY_SIZEH}

        # Run the x11vnc + noVNC fallback web interface if enabled
        if [ "''${NOVNC_ENABLE,,}" = "true" ]; then
            if [ -n "$NOVNC_VIEWPASS" ]; then export NOVNC_VIEWONLY="-viewpasswd ''${NOVNC_VIEWPASS}"; else unset NOVNC_VIEWONLY; fi
            ${pkgs.x11vnc}/bin/x11vnc -display "''${DISPLAY}" -passwd "''${SELKIES_BASIC_AUTH_PASSWORD:-$PASSWD}" -shared -forever -repeat -xkb -snapfb -threads -xrandr "resize" -rfbport 5900 ''${NOVNC_VIEWONLY} &
            ${pkgs.novnc}/bin/novnc --vnc localhost:5900 --listen 8080 --heartbeat 10 &
        fi

        # Use VirtualGL to run the desktop environment with OpenGL if the GPU is available, otherwise use OpenGL with llvmpipe
        export XDG_SESSION_ID="$${DISPLAY#*:}"
        if [ -n "$(nvidia-smi --query-gpu=uuid --format=csv,noheader | head -n1)" ] || [ -n "$(ls -A /dev/dri 2>/dev/null)" ]; then
            export VGL_FPS="''${DISPLAY_REFRESH}"
            ${pkgs.virtualgl}/bin/vglrun -d "''${VGL_DISPLAY:-egl}" +wm ${pkgs.dbus}/bin/dbus-launch "${sessionScript}/bin/script" &
        else
            ${pkgs.dbus}/bin/dbus-launch "${sessionScript}/bin/script" &
        fi

        # Start Fcitx input method framework
        ${pkgs.fcitx5}/bin/fcitx5 &

        sleep inf
        '';

        wantedBy = [ "default.target" ];
    };
}
