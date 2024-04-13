{ config, lib, inputs, ... }:

let
    defaults = import ../default-container.nix { inherit config; };
    name = "media"; # Must be defined in host-and-container's xorgSessionNumbers
in
{
    containers.${name} = {
        inherit (defaults) ephemeral autoStart privateNetwork additionalCapabilities allowedDevices;

        bindMounts = with { inherit(defaults) bindMounts; }; lib.mkMerge [
            bindMounts
            # Give access to container's exclusive X display only
            { "/tmp/.X11-unix/X${builtins.toString config.ethorbit.workstation.xorg.sessionNumbers.${name}}".isReadOnly = true; }
        ];

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
