{ config, pkgs, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        systemd.user.slices = {
            "gaming" = {
                Unit = {
                    Description = "Slice for game-related processes";
                };

                Slice = {
                    CPUAccounting = true;
                    CPUQuota = "400%";
                    # Default is 100.
                    CPUWeight = 1000;
                    StartupCPUWeight = 1000;
                    MemoryMax = "50%";
                };
            };
        };
    };
}
