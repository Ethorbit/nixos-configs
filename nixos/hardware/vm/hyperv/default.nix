{ config, pkgs, ... }:

{
    virtualisation.hypervGuest.enable = true;

    environment.systemPackages = with pkgs; [
        linuxKernel.packages.linux_6_1.vm-tools
        linuxKernel.packages.linux_6_1.hyperv-daemons
    ];
}
