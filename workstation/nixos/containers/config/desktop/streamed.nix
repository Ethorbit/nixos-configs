# Note: A NVIDIA gpu can only be used for one Xorg server at a time
# Virtualgl is used to forward OpenGL acceleration from the GPU into the X server
# so that graphics acceleration in multiple containers is possible.

{ config, lib, ... }:

{
    config = lib.mkIf (config.ethorbit.container.desktop.streamed == true) {
        ethorbit.container.desktop.command = "exec vglrun -d egl startxfce4";

        environment.variables = {
            DISPLAY = ":0";
        };

        services.xserver =  {
            videoDrivers = [ "dummy" ]; #"nvidia" ];
           
            # Taken from docker-steam-headless's /templates xorg.dummy.conf
            config = lib.mkForce ''
                Section "Device"
                    Identifier      "Configured Video Device"
                    Driver          "dummy"
                    VideoRam        256000
                EndSection
        
                Section "Monitor"
                    Identifier      "Configured Monitor"
                    HorizSync       5.0 - 1000.0
                    VertRefresh     5.0 - 200.0
                    ModeLine        "1920x1080" 148.50 1920 2448 2492 2640 1080 1084 1089 1125 +Hsync +Vsync
                EndSection
        
                Section "Screen"
                    Identifier      "Default Screen"
                    Monitor         "Configured Monitor"
                    Device          "Configured Video Device"
                    DefaultDepth    24
                    SubSection      "Display"
                        Depth           24
                        Modes           "1920x1080" "1280x800" "1024x768" "1920x1080" "1600x900" "1440x900"
                    EndSubSection
                EndSection
            '';
        };
    };
}
