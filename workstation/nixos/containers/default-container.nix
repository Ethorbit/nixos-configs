{ config, ... }:

{
    ephemeral = false;

    autoStart = true;

    privateNetwork = true;

    additionalCapabilities = [];

    bindMounts = {
        # Needed so that the containers can read their own age secrets
        ${config.ethorbit.age.identityPath}.isReadOnly = true;

        "/dev/shm" = {};
        "/dev/fuse" = {};
        "/tmp/.X11-unix".isReadOnly = true;
        "/dev/vga_arbiter" = {};
        "/dev/dri" = {};
        "/dev/nvidia-modeset" = {};
        "/dev/nvidia-uvm" = {};
        "/dev/nvidia-uvm-tools" = {};
        "/dev/nvidiactl" = {};
        "/dev/nvidia0" = {};
    };

    allowedDevices = [
        {
            modifier = "rw";
            node = "/dev/dri/renderD128";
        }
        {
            modifier = "rw";
            node = "/dev/dri/card0";
        }
        {
            modifier = "rw";
            node = "/dev/nvidia-modeset";
        }
        {
            modifier = "rw";
            node = "/dev/nvidia-uvm";
        }
        {
            modifier = "rw";
            node = "/dev/nvidia-uvm-tools";
        }
        {
            modifier = "rw";
            node = "/dev/nvidiactl";
        }
        {
            modifier = "rw";
            node = "/dev/nvidia0";
        }
    ];
}
