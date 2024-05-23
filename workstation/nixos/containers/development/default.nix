{ config, lib, inputs, system, ... }:

let
    defaults = import ../default-container.nix { inherit config; };
    name = "development";
in
{
    containers.${name} = {
        inherit (defaults) ephemeral autoStart privateNetwork localAddress hostBridge additionalCapabilities allowedDevices;

        config = { config, ... }: {
            ethorbit.users.primary.username = name;

            imports = [
                (import ../../../../nixosmodules.nix { inherit inputs; inherit system; })
                ../config
                ./config
            ];
        };
    };
}
