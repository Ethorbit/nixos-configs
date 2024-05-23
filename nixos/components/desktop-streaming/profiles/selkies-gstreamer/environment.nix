{ config, lib, ... }:

{
    environment = {
        variables = with config.ethorbit.components.selkies-gstreamer; with settings; with display; with resolution; with auth; {
            DISPLAY = ":0";
            PULSE_SERVER = "unix:/run/pulse/native";
            SIZEW = builtins.toString width;
            SIZEH = builtins.toString height;
            REFRESH = builtins.toString refreshRate;
            DPI = builtins.toString dpi;
            CDEPTH = builtins.toString colorDepth;
            VGL_REFRESHRATE = builtins.toString refreshRate;
            VGL_DISPLAY = "egl";
            __GL_SYNC_TO_VBLANK = "0";
            NOVNC_ENABLE = builtins.toString useNOVNC;
            NOVNC_VIEWPASS = password;
            WEBRTC_ENCODER = webRTC.encoder;
            WEBRTC_ENABLE_RESIZE = builtins.toString webRTC.enableResize;
            ENABLE_BASIC_AUTH = "true";
            BASIC_AUTH_PASSWORD = password;
            PASSWD = password;
            PASSWD_FILE = passwordFile;
            GTK_IM_MODULE = "fcitx";
            QT_IM_MODULE = "fcitx";
            XIM = "fcitx";
            XMODIFIERS = "@im=fcitx";
            TURN_HOST = turn.host;
            TURN_PORT = builtins.toString turn.port;
            TURN_PROTOCOL = turn.protocol;
            TURN_TLS = builtins.toString turn.tls;
            TURN_SHARED_SECRET = builtins.toString turn.sharedSecret;
            TURN_SHARED_SECRET_FILE = builtins.toString turn.sharedSecretFile;
        };

        # [ -s "$PASSWD_FILE" ] && export PASSWD=$(cat "$PASSWD_FILE") && export BASIC_AUTH_PASSWORD="$PASSWD"
        # [ -s "$TURN_SHARED_SECRET_FILE" ] && export TURN_SHARED_SECRET=$(cat "$TURN_SHARED_SECRET_FILE")

        # These environment files will be sourced by user services
        #etc = {
        #    "/default/selkies-gstreamer" = with config.environment.variables; {
        #        text = ''
        #        export XIM="${XIM}"
        #        export XMODIFIERS="${XMODIFIERS}"
        #        export PULSE_SERVER="${PULSE_SERVER}"
        #        export WEBRTC_ENCODER="${WEBRTC_ENCODER}"
        #        export WEBRTC_ENABLE_RESIZE="${WEBRTC_ENABLE_RESIZE}"
        #        export VGL_REFRESHRATE="${VGL_REFRESHRATE}"
        #        export VGL_DISPLAY="${VGL_DISPLAY}"
        #        export CDEPTH="${CDEPTH}"
        #        export DPI="${DPI}"
        #        export SIZEW="${SIZEW}"
        #        export SIZEH="${SIZEH}"
        #        export DISPLAY="${DISPLAY}"
        #        export NOVNC_ENABLE="${NOVNC_ENABLE}"
        #        export NOVNC_VIEWPASS="${NOVNC_VIEWPASS}"
        #        export TURN_HOST="${TURN_HOST}"
        #        export TURN_PORT="${TURN_PORT}"
        #        export TURN_PROTOCOL="${TURN_PROTOCOL}"
        #        export TURN_TLS="${TURN_TLS}"
        #        export TURN_SHARED_SECRET="${TURN_SHARED_SECRET}"
        #        export ENABLE_BASIC_AUTH="${ENABLE_BASIC_AUTH}"
        #        export BASIC_AUTH_PASSWORD="${BASIC_AUTH_PASSWORD}"
        #        export PASSWD="${PASSWD}" 
        #        '';
        #    };

        #    "/default/pulseaudio" = with config.environment.variables; {
        #        text = ''
        #        export XMODIFIERS="${XMODIFIERS}"
        #        export DISPLAY="${DISPLAY}"
        #        export PULSE_SERVER="${PULSE_SERVER}"
        #        '';
        #    };
        #};
    };
}
