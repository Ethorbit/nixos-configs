{ config, ... }:

{
    # We need to optimize the slices to reduce lag
    # during resource contention
    systemd.slices = {
        # Host
        "user".sliceConfig = {
            IOAccounting = true;
            BlockIOAccounting = true;
            CPUAccounting = true;
            CPUWeight = 100;
            IOWeight = 100;
            BlockIOWeight = 100;
        };

        "system".sliceConfig = {
            IOAccounting = true;
            BlockIOAccounting = true;
            CPUAccounting = true;
            CPUWeight = 100;
            IOWeight = 100;
            BlockIOWeight = 100;
        };

        # Containers, leave some resources for host
        "machine".sliceConfig = {
            IOAccounting = true;
            CPUAccounting = true;
            BlockIOAccounting = true;
            CPUWeight = 60;
            StartupCPUWeight = 60;
            IOWeight = 80;
            BlockIOWeight = 80;
            MemoryMax = "90%";
        };

        "container" = {
            sliceConfig = config.systemd.slices."machine".sliceConfig;
        };
    };
}
