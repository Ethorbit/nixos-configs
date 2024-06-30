{ config, lib, ... }:

{
    imports = [
        ../bash
        ../zsh
    ];

    options.ethorbit.home-manager.shell = with lib; {
        prompt = {
            alternative = mkOption {
                type = types.str;
                description = "Choose between twoline, oneline and backtrack for prompt.";
                default = "twoline";
            };

            symbol = mkOption {
                type = types.str;
                description = "The prompt symbol between user and host";
                default = "🔮";
            };

            newline = mkOption {
                type = types.str;
                description = "Whether or not to insert a new line for each prompt.";
                default = "yes";
            };

            color = mkOption {
                type = types.str;
                default = "\\\\[\\\\e[36m\\\\]";
            };

            colorinfo = mkOption {
                type = types.str;
                default = "${config.ethorbit.home-manager.shell.prompt.color}";
            };
        };
    };
}
