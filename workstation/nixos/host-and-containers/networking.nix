{ config, ... }:

{
    # Private bridge interface, Gateway VM
    networking.defaultGateway.address = "172.16.1.1";
}
