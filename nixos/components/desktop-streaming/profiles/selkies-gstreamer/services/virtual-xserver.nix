{ config, pkgs, ... }:

let
    # this script is passed as the command to run with xvfb-run, so we should have a valid X environment to work with
    XvfbCommand = pkgs.writeShellScriptBin "script" ''
        export XDG_RUNTIME_DIR=/run/user/$(id -u)
        export PATH="$PATH:/run/current-system/sw/bin"

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
            ${pkgs.virtualgl}/bin/vglrun -d "''${VGL_DISPLAY:-egl}" +wm ${pkgs.dbus}/bin/dbus-launch "${config.services.xserver.displayManager.sessionCommands}" &
        else
            ${pkgs.dbus}/bin/dbus-launch "${config.services.xserver.displayManager.sessionCommands}" &
        fi

        # Start Fcitx input method framework
        ${pkgs.fcitx5}/bin/fcitx5 &

        sleep inf
    '';
in
{
    config = {
        systemd.services."virtual-xserver" = {
            enable = true;
            description = "Systemd + nix port of nvidia-egl-docker's 'entrypoint' supervisor service, which is responsible for starting the virtual X server and the desktop.";
            environment = config.environment.variables;

            serviceConfig = {
                User = config.ethorbit.components.selkies-gstreamer.settings.user;
                Type = "simple";
                Restart = "on-failure";
                RestartSec = 5;
            };

            script = ''
                trap "echo TRAPed signal" HUP INT QUIT TERM

                # Run Xvfb server and its commands with required extensions
                ${pkgs.xvfb-run}/bin/xvfb-run \
                    --server-num=${builtins.toString config.ethorbit.components.selkies-gstreamer.settings.display.number} \
                    --server-args="-ac -screen 0 8192x4096x''${CDEPTH} -dpi ''${DPI} +extension COMPOSITE +extension DAMAGE +extension GLX +extension RANDR +extension RENDER +extension MIT-SHM +extension XFIXES +extension XTEST +iglx +render -nolisten tcp -noreset -shmem" \
                    "${XvfbCommand}/bin/script"
            '';

            wantedBy = [ "default.target" ];
        };
    };
}
