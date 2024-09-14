{ config, lib, pkgs, ... }:

with lib;
{
    options.ethorbit.home-manager.nvim = {
        godotPath = mkOption {
            default = "${pkgs.godot_4}/bin/godot_4";
            description = "The path to the godot binary that neovim will edit scripts for.";
        };
    };
}
