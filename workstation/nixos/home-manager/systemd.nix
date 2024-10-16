{ config, pkgs, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        # Steam uses high CPU usage during compression of downloads
        # Some AAA games might also have poor optimization
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
