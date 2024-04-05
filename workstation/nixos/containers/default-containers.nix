{ config, ... }:

{
    #hostBridge = "br0";
    
    bindMounts = {
        # Needed so that the containers can read their own age secrets
        ${config.ethorbit.age.identityPath}.isReadOnly = true;

        # We need to make the graphics devices visible
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
