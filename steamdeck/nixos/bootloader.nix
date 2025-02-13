{ config, ... }:

{
    boot = {
        kernel.sysctl = {
            "net.ipv4.ip_forward" = 1;
            "vm.swappiness" = 60;
        };
        kernelParams = [
            "elevator=bfq"
            "tsc=directsync"
            "amd_iommu=off"
            "amdgpu.gttsize=8128"
            "spi_amd.speed_dev=1"
            "fbcon=vc:4-6"
            "fbcon=rotate:1"
            "log_buf_len=4M"
            "rd.systemd.gpt_auto=no"
        ];
        loader = {
            efi.canTouchEfiVariables = true;
            systemd-boot.enable = true;
        };
    };
}
