{ config, inputs, ... }:

let
    defaults = import ../default-containers.nix { inherit config; };
in
{
    containers."development" = {
        autoStart = true;
        privateNetwork = false;
        interfaces = [ "eth1" ];
        inherit (defaults) bindMounts allowedDevices;
        config = { config, ... }: {
            imports = [
                (import ../../../../nixosmodules.nix { inherit inputs; })
                ../default-containers-config
                ./users.nix
            ];
        };
    };
}
