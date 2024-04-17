{ config, ... }:

{
    environment.variables = {
        DISPLAY = ":${builtins.toString config.ethorbit.workstation.xorg.sessionNumbers.${config.ethorbit.users.primary.username}}";
    
        # Following morrolinux's guide for GPU accelerated container
          # "make sure you've disabled X11 shared memory as it won't work"
        QT_X11_NO_MITSHM = "1";
    };
}
