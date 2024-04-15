{ config, ... }:

{
    ephemeral = false;

    autoStart = false;

    privateNetwork = true;
    localAddress = null;

    hostBridge = "br0";

    additionalCapabilities = [];

    bindMounts = {
        # Needed so that the containers can read their own age secrets
        ${config.ethorbit.age.identityPath}.isReadOnly = true;

        "/dev/shm" = {};
        "/dev/fuse" = {};

        # Allow container to use the GPU
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
            modifier = "rwm";
            node = "/dev/fuse";
        }
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
