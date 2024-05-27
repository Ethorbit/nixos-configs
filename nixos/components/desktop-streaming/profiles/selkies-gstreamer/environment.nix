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
}
