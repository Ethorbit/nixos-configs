{ config, ... }:

{
    ephemeral = false;

    autoStart = false;

    privateNetwork = true;
    localAddress = null;

    hostBridge = "br0";

    additionalCapabilities = [ "CAP_SYS_ADMIN" ];

    bindMounts = {
        # Needed so that the containers can read their own age secrets
        ${config.ethorbit.age.identityPath}.isReadOnly = true;

        "/dev/shm" = {};
        "/dev/fuse" = {};
        "/sys/module".isReadOnly = true;

        # GPU
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

        # GPU
        {
            modifier = "rwm";
            node = "char-drm";
        }
        {
            modifier = "rwm";
            node = "/dev/dri/renderD128";
        }
        {
            modifier = "rwm";
            node = "/dev/dri/card0";
        }
        {
            modifier = "rwm";
            node = "/dev/nvidia-modeset";
        }
        {
            modifier = "rwm";
            node = "/dev/nvidia-uvm";
        }
        {
            modifier = "rwm";
            node = "/dev/nvidia-uvm-tools";
        }
        {
            modifier = "rwm";
            node = "/dev/nvidiactl";
        }
        {
            modifier = "rwm";
            node = "/dev/nvidia0";
        }
    ];
}
