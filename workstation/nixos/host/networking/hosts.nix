{ config, lib, ... }:

with lib;

{
    # Add host entries for each container
    networking.hosts = (mkMerge (map (name: {
        "127.0.0.1" = [ "container.${name}.${config.networking.hostName}.internal" ];
        "${config.ethorbit.workstation.containers.entries."${name}".ip}" = [ "container.${name}.internal" ];
    }) (attrNames config.ethorbit.workstation.containers.entries)));
}
