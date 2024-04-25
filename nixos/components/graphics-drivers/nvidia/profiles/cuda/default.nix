{ config, lib, pkgs, ... }:

{
    nixpkgs.config.cudaSupport = true;

    environment.systemPackages = with pkgs; [
        cudaPackages.cudatoolkit
    ];

    # WSL requires some path variables to be set to work with CUDA
    environment.variables = with pkgs; lib.mkIf config.wsl.enable {
        CUDA_PATH="${cudaPackages.cudatoolkit}";
        NIX_LD_LIBRARY_PATH="/usr/lib/wsl/lib";
        LD_LIBRARY_PATH="/usr/lib/wsl/lib:${linuxPackages.nvidia_x11}/lib:${ncurses5}/lib";
        EXTRA_LDFLAGS="-L/lib -L${linuxPackages.nvidia_x11}/lib";
        EXTRA_CCFLAGS="-I/usr/include";
    };
}
