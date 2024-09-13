{ config, lib, pkgs, ... }:

with lib;
with pkgs;

{
    options.ethorbit.pkgs.godot4-mono = mkOption {
        type = types.package;
        default = (import ./derivation.nix { inherit pkgs; inherit lib; });
    };
}
