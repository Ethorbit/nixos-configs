{ config, lib, pkgs, ... }:

{
    options = with lib; with pkgs; {
        ethorbit.termdown-wrapper.soundPath = mkOption {
            type = types.str;
            description = "The sound file to play when the timer interval has finished.";
            default = "";
        };

        ethorbit.pkgs.script.termdown-wrapper = mkOption {
            type = types.package;
            default = pkgs.writeShellScriptBin "timer.sh" ''
            #!/usr/bin/env bash
            termdown $(("$1")) && cvlc -L "${config.ethorbit.termdown-wrapper.soundPath}"
            '';
        };
    };
}
