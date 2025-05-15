# Since almost every computer is multithreaded now,
# I'm enabling irqbalance by default to distribute
# hardware interrupts (IRQs) evenly across multiple CPU cores
# for better performance.

{ config, lib, ... }:

{
    services.irqbalance.enable = lib.mkDefault true;
    # workaround needed
    # https://github.com/NixOS/nixpkgs/issues/371415
    systemd.services.irqbalance.serviceConfig = lib.mkIf (config.services.irqbalance.enable) {
        ProtectKernelTunables = "no";
    };
}
