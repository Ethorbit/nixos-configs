{ config, ... }:

{
    #hostBridge = "br0";

    # Sunshine requires some capabilities
    # for configuring displays and graphics settings
    # it is unfortunately not optional
    additionalCapabilities = [
        "CAP_SYS_ADMIN"
    ];
   
    bindMounts = {
        # Needed so that the containers can read their own age secrets
        ${config.ethorbit.age.identityPath}.isReadOnly = true;

        # We need to make the graphics devices visible
        "/dev/dri" = {};
        "/dev/nvidia-modeset" = {};
        "/dev/nvidia-uvm" = {};
        "/dev/nvidia-uvm-tools" = {};
        "/dev/nvidiactl" = {};
        "/dev/nvidia0" = {};
    };

    # We need to grant access to the graphics devices
    allowedDevices = [
        {
            modifier = "rw";
            node = "/dev/dri/card0";
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
