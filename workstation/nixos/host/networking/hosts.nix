{ config, lib, ... }:

with lib;

{
    # Add host entry for each container (container.container-name-here.internal)
    networking.hosts = (mkMerge (map (name: {
        "${config.ethorbit.workstation.containers.entries."${name}".ip}" = [ "container.${name}.internal" ];
    }) (attrNames config.ethorbit.workstation.containers.entries)));
}
