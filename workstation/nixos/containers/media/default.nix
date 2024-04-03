{ config, inputs, ... }:

{
    containers."media" = {
        autoStart = true;
        privateNetwork = true;
        # needed for reading agenix secrets used inside container config
        bindMounts.${config.ethorbit.age.identityPath}.isReadOnly = true;
        config = { config, lib, ... }: {
            imports = [
                (import ../../../../nixosmodules.nix { inherit inputs; })
                ../default-container.nix
                ./users.nix
            ];
        };
    };
}
