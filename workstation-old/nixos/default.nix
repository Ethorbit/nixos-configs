{ config, ... }:

{
    imports = [
        ./host
        ./host-and-nspawn-containers
        ./containers
    ];
}
