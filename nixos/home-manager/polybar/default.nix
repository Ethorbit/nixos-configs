{ config, ... }:

{
    # Apparently there's no way to recursively set executable flag (recursive = true changed nothing)
    # so I will now proceed to make a separate entry for every single
    # script and question why I'm even using Nix to manage my home
    # when I could be using Arch Linux with backups and not 
    # have to deal with any of this trouble

    # if there's a better way, I would be surprised if a soul knew about it
    # because according to Google and its empty results, I'm the only person in the world to run into this problem
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file = {
            ".config/polybar/config" = {
                source = ./config/config;
            };
            ".config/polybar/launch.sh" = {
                source = ./config/launch.sh;
                executable = true;
            };
            ".config/polybar/polybar-scripts/mocp/song-name.sh" = {
                source = ./config/polybar-scripts/mocp/song-name.sh;
                executable = true;
            };
            ".config/polybar/polybar-scripts/mocp/toggleplay.sh" = {
                source = ./config/polybar-scripts/mocp/toggleplay.sh;
                executable = true;
            };
            ".config/polybar/polybar-scripts/mocp/state.sh" = {
                source = ./config/polybar-scripts/mocp/state.sh;
                executable = true;
            };
            ".config/polybar/polybar-scripts/nvidia/gpu.sh" = {
                source = ./config/polybar-scripts/nvidia/gpu.sh;
                executable = true;
            };
            ".config/polybar/polybar-scripts/nvidia/gpu-usage.sh" = {
                source = ./config/polybar-scripts/nvidia/gpu-usage.sh;
                executable = true;
            };
            ".config/polybar/polybar-scripts/nvidia/gpu-temperature.sh" = {
                source = ./config/polybar-scripts/nvidia/gpu-temperature.sh;
                executable = true;
            };
            ".config/polybar/polybar-scripts/amd/gpu.sh" = {
                source = ./config/polybar-scripts/amd/gpu.sh;
                executable = true;
            };
            ".config/polybar/polybar-scripts/amd/cpu.sh" = {
                source = ./config/polybar-scripts/amd/cpu.sh;
                executable = true;
            };
            ".config/polybar/polybar-scripts/amd/gpu-usage.sh" = {
                source = ./config/polybar-scripts/amd/gpu-usage.sh;
                executable = true;
            };
            ".config/polybar/polybar-scripts/amd/gpu-temperature.sh" = {
                source = ./config/polybar-scripts/amd/gpu-temperature.sh;
                executable = true;
            };
            ".config/polybar/polybar-scripts/amd/cpu-usage.sh" = {
                source = ./config/polybar-scripts/amd/cpu-usage.sh;
                executable = true;
            };
            ".config/polybar/polybar-scripts/amd/cpu-temperature.sh" = {
                source = ./config/polybar-scripts/amd/cpu-temperature.sh;
                executable = true;
            };
            ".config/polybar/polybar-scripts/scream/scream.sh" = {
                source = ./config/polybar-scripts/scream/scream.sh;
                executable = true;
            };
            ".config/polybar/polybar-scripts/scream/toggle.sh" = {
                source = ./config/polybar-scripts/scream/toggle.sh;
                executable = true;
            };
            ".config/polybar/polybar-scripts/microphone.sh" = {
                source = ./config/polybar-scripts/microphone.sh;
                executable = true;
            };
            ".config/polybar/polybar-scripts/weather.sh" = {
                source = ./config/polybar-scripts/weather.sh;
                executable = true;
            };
            ".config/polybar/polybar-scripts/memory-available.sh" = {
                source = ./config/polybar-scripts/memory-available.sh;
                executable = true;
            };
        };
        
        services.polybar.script = "";
        services.polybar.enable = true;
    };
}
