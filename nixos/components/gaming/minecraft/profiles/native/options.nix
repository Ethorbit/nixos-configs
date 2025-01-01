{ config, lib, ... }:

with lib;

{
    options.ethorbit.components.gaming.minecraft.launcher.gamescope.flags = mkOption {
        type = types.listOf types.str;
        default = [
            "-r 60"
            "-w 1920"
            "-h 1080"
            "-W 1920"
            "-H 1080"
            "-f"
            "--immediate-flips"
            "--force-grab-cursor"
        ];
    };
}
