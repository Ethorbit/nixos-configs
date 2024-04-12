{ config, lib, inputs, ... }:

let
    defaults = import ../default-containers.nix { inherit config; };
in
{
    #containers."development" = {
    #    autoStart = true;
    #    privateNetwork = false;
    #    interfaces = [ "eth1" ];
    #    inherit (defaults) bindMounts allowedDevices additionalCapabilities;
    #    config = { config, ... }: {
    #        environment.variables.DISPLAY = ":2";
    #        imports = [
    #            (import ../../../../nixosmodules.nix { inherit inputs; })
    #            ../default-containers-config
    #            ./users.nix
    #        ];
    #    };
    #};
}
