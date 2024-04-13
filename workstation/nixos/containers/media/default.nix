{ config, inputs, ... }:

let
    defaults = import ../default-container.nix { inherit config; };
    name = "media"; # Must be defined in host-and-container's xorgSessionNumbers
in
{
    containers.${name} = {
        inherit (defaults) ephemeral autoStart privateNetwork additionalCapabilities bindMounts allowedDevices;
        config = { config, ... }: {
            ethorbit.users.primary.username = name;

            imports = [
                (import ../../../../nixosmodules.nix { inherit inputs; })
                ../config
                ./config
            ];
        };
    };
}
