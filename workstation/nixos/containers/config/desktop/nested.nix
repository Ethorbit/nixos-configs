{ config, lib, ... }:

{
    config = lib.mkIf (config.ethorbit.container.desktop.streamed == false) {
        ethorbit = {
            services.selkies-gstreamer.enable = lib.mkForce false;
            container.desktop.command = "exec startxfce4";
        };

        environment.variables = {
            # On the host this display is created by an X nesting application (like Xephyr)
            # That X display should be bind mounted to this container
            # If that doesn't happen, this container will not work!
            DISPLAY = ":${builtins.toString config.ethorbit.workstation.xorg.sessionNumbers.${config.ethorbit.users.primary.username}}";
        };

        # Use host's audio output device
        hardware.pulseaudio.zeroconf.discovery.enable = true;
    };
}
