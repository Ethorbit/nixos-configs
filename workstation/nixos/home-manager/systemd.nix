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
                    # Default is 100.
                    CPUWeight = 100;
                    StartupCPUWeight = 100;
                    MemoryMax = "50%";
                };
            };
        };
    };
}
