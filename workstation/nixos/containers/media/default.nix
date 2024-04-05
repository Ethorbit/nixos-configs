{ config, inputs, ... }:

let
    defaults = import ../default-containers.nix { inherit config; };
in
{
    containers."media" = {
        autoStart = true;
        privateNetwork = false;
        interfaces = [ "eth2" ];
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
