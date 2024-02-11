{ config, ... }:

{
    services.xserver.xrandrHeads = [
        {
            output = "Virtual-1";
            primary = true;
            monitorConfig = ''
                Option "PreferredMode" "1920x1080"
            '';
        }
    ];
}
