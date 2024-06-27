{ config, lib, ... }:

with config.ethorbit.components.selkies-gstreamer;
with settings;
with display;
with resolution;
with auth;
{
    # This is a port of the Docker container's environment. It should have all the same stuff set.
    environment.variables = {
        DISPLAY = ":${builtins.toString number}";
        #PULSE_SERVER = "unix:/run/pulse/native";
        SIZEW = builtins.toString width;
        SIZEH = builtins.toString height;
        REFRESH = builtins.toString refreshRate;
        DPI = builtins.toString dpi;
        CDEPTH = builtins.toString colorDepth;
        VGL_REFRESHRATE = builtins.toString refreshRate;
        VGL_DISPLAY = "egl";
        GST_DEBUG = "*:2";
        SDL_JOYSTICK_DEVICE = "/dev/input/js0";
        __GL_SYNC_TO_VBLANK = "0";
        NOVNC_ENABLE = builtins.toString useNOVNC;
        NOVNC_VIEWPASS = password;
        WEBRTC_ENCODER = webRTC.encoder;
        WEBRTC_ENABLE_RESIZE = builtins.toString webRTC.enableResize;
        SELKIES_ENABLE_RESIZE = builtins.toString webRTC.enableResize;
        SELKIES_ENABLE_BASIC_AUTH = "true";
        SELKIES_BASIC_AUTH_PASSWORD = password;
        PASSWD = password;
        PASSWD_FILE = passwordFile;
        GTK_IM_MODULE = "fcitx";
        QT_IM_MODULE = "fcitx";
        XIM = "fcitx";
        XMODIFIERS = "@im=fcitx";
        SELKIES_TURN_HOST = turn.host;
        SELKIES_TURN_PORT = builtins.toString turn.port;
        SELKIES_TURN_PROTOCOL = turn.protocol;
        SELKIES_TURN_TLS = builtins.toString turn.tls;
        SELKIES_TURN_SHARED_SECRET = builtins.toString turn.sharedSecret;
        SELKIES_TURN_SHARED_SECRET_FILE = builtins.toString turn.sharedSecretFile;
    };
}
