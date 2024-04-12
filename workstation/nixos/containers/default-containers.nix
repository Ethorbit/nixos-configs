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

        # Not required, but the purpose of shm is to be shared
        "/dev/shm" = {};

        "/dev/fuse" = {};

        # Commented because it is much more secure if the container creates 
        # its own X socket, rather than sharing it with host.
        #"/tmp/.X11-unix".isReadOnly = true;

        # We need to make the devices Sunshine needs visible
        "/dev/uinput" = {};
        #"/dev/input" = {};
        "/dev/vga_arbiter" = {};
        "/dev/dri" = {};
        "/dev/nvidia-modeset" = {};
        "/dev/nvidia-uvm" = {};
        "/dev/nvidia-uvm-tools" = {};
        "/dev/nvidiactl" = {};
        "/dev/nvidia0" = {};
    };

    # We need to grant access to the devices used by Sunshine
    allowedDevices = [
        {
            modifier = "rwm";
            node = "/dev/uinput";
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
