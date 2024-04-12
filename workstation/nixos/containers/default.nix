{ config, ... }:

{
    imports = [
        ./development
        ./media
    ];

    # Keep GPU awake during headless mode.
    #hardware.nvidia.nvidiaPersistenced = true;
}
