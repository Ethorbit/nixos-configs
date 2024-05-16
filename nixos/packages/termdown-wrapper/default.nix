{ config, lib, pkgs, ... }:

{
    options = {
        ethorbit.pkgs.termdown-wrapper = with pkgs; with lib; {
            soundPath = mkOption {
                type = types.str;
                description = "The sound file to play when the timer interval has finished.";
                default = "";
            };

            package = mkOption {
                type = types.package;
                default = pkgs.writeShellScriptBin "timer.sh" ''
                #!/usr/bin/env bash
                termdown $(("$1")) && cvlc -L "${config.ethorbit.pkgs.termdown-wrapper.soundPath}"
                '';
            };
        };
    };
}
