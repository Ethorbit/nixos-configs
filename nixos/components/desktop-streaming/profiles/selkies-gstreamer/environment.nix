{ config, lib, ... }:

with config.ethorbit.components.selkies-gstreamer;
with settings;
with display;
with resolution;
with auth;
{
    environment.sessionVariables = {
        # Needs to be a session variable or many programs will fail to run..
        DISPLAY = ":${builtins.toString number}";
    };

    # This is a port of the Docker container's environment. It should have all the same stuff set.
    environment.variables = {
        DISPLAY = ":${builtins.toString number}";
        DISPLAY_SIZEW = builtins.toString width;
        DISPLAY_SIZEH = builtins.toString height;
        DISPLAY_REFRESH = builtins.toString refreshRate;
        DISPLAY_DPI = builtins.toString dpi;
        DISPLAY_CDEPTH = builtins.toString colorDepth;
        VGL_REFRESHRATE = builtins.toString refreshRate;
        VGL_DISPLAY = "egl";
        # Changed from :2 to :1 (WARNING to ERROR) because of a flooding of useless warnings.
        GST_DEBUG = "*:1";
        SDL_JOYSTICK_DEVICE = "/dev/input/js0";
        __GL_SYNC_TO_VBLANK = "0";
        # NOVNC is being removed soon in favor of KASM.
        NOVNC_ENABLE = builtins.toString useNOVNC;
        # Haven't ported KASM yet from the new 1.6.0 changes, will do so once everything else works perfectly.
        #KASMVNC_ENABLE = builtins.toString useKasmVNC;
        NOVNC_VIEWPASS = password;
        SELKIES_PORT = builtins.toString port;
        SELKIES_ADDR = address;
        SELKIES_ENCODER = webRTC.encoder;
        SELKIES_ENABLE_RESIZE = builtins.toString webRTC.enableResize;
        SELKIES_VIDEO_BITRATE = builtins.toString webRTC.videoBitRate;
        SELKIES_AUDIO_BITRATE = builtins.toString webRTC.audioBitRate;
        SELKIES_FRAMERATE = builtins.toString webRTC.fps;
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

        # Steam's Proton will want to use Vulkan renderer for games, but we want OpenGL for VirtualGL compatibility
        PROTON_USE_WINED3D = "1";
    };
}
