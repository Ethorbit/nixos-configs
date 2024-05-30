{ config, ... }:

{
    # Private bridge interface, Gateway VM
    networking.defaultGateway.address = "172.12.1.1";
}
