{ config, ... }:

{
    home-manager.sharedModules = [ {
        services.polybar.config = {
            "module/nvidia-gpu" = {
                type = "custom/script";
                exec = "${config.ethorbit.polybar.scripts.nvidia.gpu.outPath}";
                format = "NVIDIA GPU: <label>";
                format-underline = "#f50a4d";
                interval = 5;
            };

            "module/amd-gpu" = {
                type = "custom/script";
                exec = "${config.ethorbit.polybar.scripts.amd.gpu.outPath}";
                format-prefix="⬛ ";
                #format-prefix="▣ ";
                format = "AMD GPU: <label>";
                format-offset = ""; # -4
                format-underline = "#f50a4d";
                interval = 5;
            };
        };
    } ];
}
