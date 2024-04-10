{ config, ... }:

{
    boot.initrd.availableKernelModules = [
        "virtio"
        "virtio_pci"
        "virtio_scsi"
        "virtio_net"
        "virtio_balloon"
        "virtio_ring"
    ];
}
