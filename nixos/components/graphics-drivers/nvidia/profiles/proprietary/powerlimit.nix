{ config, lib, ... }:

with lib;

let
    cfg = config.ethorbit.graphics.nvidia.proprietary;
in
{
    config = mkIf cfg.powerLimit.enable {
        hardware.nvidia.nvidiaPersistenced = true;

        systemd.services."nvidia-power-limit" = {
            enable = true;
            description = "NVIDIA Power Limit Service";
            after = [ "nvidia-persistenced.service" ];
            requires = [ "nvidia-persistenced.service" ];
            script = ''
                /run/current-system/sw/bin/nvidia-smi -pm 1
                /run/current-system/sw/bin/nvidia-smi -pl ${toString cfg.powerLimit.limit}
            '';
            serviceConfig = {
                Type = "oneshot";
            };
            wantedBy = [ "multi-user.target" ];
        };
    };
}
