{ ... }:

{
    virtualisation.vmVariant = {
        virtualisation = {
            diskSize = 20480;
            memorySize = 4096;

            forwardPorts = [
                {
                    from = "host";
                    host.port = 2222;
                    guest.port = 22;
                }
            ];
        };
    };
}
