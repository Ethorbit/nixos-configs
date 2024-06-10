{ config, pkgs, ... }:

let
    sessionScript = pkgs.writeShellScriptBin "script" ''
        ${config.services.xserver.displayManager.sessionCommands}
    '';
in
{
    systemd.services."virtual-desktop" = {
        enable = true;
        description = "Systemd + nix port of nvidia-egl-docker's 'entrypoint' supervisor service, the part that starts the desktop";
        environment = config.environment.variables;
        requires = [ "virtual-xserver.service" ];
        after = [ "virtual-xserver.service" ];

        serviceConfig = {
            User = config.ethorbit.components.selkies-gstreamer.settings.user;
            Type = "simple";
            Restart = "always";
            RestartSec = 5;
        };

        script = ''
        source /etc/profile

        # This fixes OpenGL video card acceleration not working. Without it, everything uses LLVMPipe.
        export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/run/opengl-driver/lib"

        # Wait for X11 to start
        echo "Waiting for X socket"
        until [ -S "/tmp/.X11-unix/X''${DISPLAY/:/}" ]; do sleep 1; done
        echo "X socket is ready"

        # Resize the screen to the provided size
        ${config.ethorbit.pkgs.python.selkies-gstreamer}/bin/selkies-gstreamer-resize ''${SIZEW}x''${SIZEH}

        # Run the x11vnc + noVNC fallback web interface if enabled
        if [ "''${NOVNC_ENABLE,,}" = "true" ]; then
            if [ -n "$NOVNC_VIEWPASS" ]; then export NOVNC_VIEWONLY="-viewpasswd ''${NOVNC_VIEWPASS}"; else unset NOVNC_VIEWONLY; fi
            ${pkgs.x11vnc}/bin/x11vnc -display "''${DISPLAY}" -passwd "''${BASIC_AUTH_PASSWORD:-$PASSWD}" -shared -forever -repeat -xkb -snapfb -threads -xrandr "resize" -rfbport 5900 ''${NOVNC_VIEWONLY} &
            ${pkgs.novnc}/bin/novnc --vnc localhost:5900 --listen 8080 --heartbeat 10 &
        fi

        # Use VirtualGL to run the desktop environment with OpenGL if the GPU is available, otherwise use OpenGL with llvmpipe
        if [ -n "$(nvidia-smi --query-gpu=uuid --format=csv | sed -n 2p)" ]; then
            export VGL_REFRESHRATE="''${REFRESH}"
            echo "Running with VirtualGL."
            ${pkgs.virtualgl}/bin/vglrun -d "''${VGL_DISPLAY:-egl}" +wm ${pkgs.dbus}/bin/dbus-launch "${sessionScript}/bin/script" &
        else
            echo "Running with LLVMPipe."
            ${pkgs.dbus}/bin/dbus-launch "${sessionScript}/bin/script" &
        fi

        # Start Fcitx input method framework
        ${pkgs.fcitx5}/bin/fcitx5 &

        sleep inf
        '';

        wantedBy = [ "default.target" ];
    };
}
