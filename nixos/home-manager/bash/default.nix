{ config, lib, ... }:

{
    options.ethorbit.home-manager.bash = with lib; {
        prompt = {
            alternative = mkOption {
                description = "Choose between twoline, oneline and backtrack for prompt.";
                default = "twoline";
            };

            symbol = mkOption {
                description = "The prompt symbol between user and host";
                default = "🔮";
            };

            newline = mkOption {
                description = "Whether or not to insert a new line for each prompt.";
                default = "yes";
            };
        };
    };

    config = {
        home-manager.users.${config.ethorbit.users.primary.username} = {  
            # so nix can stay TF outta my way and stop trying to parse properly escaped text
            # (seriously, sometimes nix is just a headache!)
            home.file.".bashrc_text" = {
                source = ./.bashrc;
                recursive = true;
            };

            home.file.".config/ble.sh".text = lib.mkDefault ''
                bleopt complete_auto_delay=300
                bleopt prompt_command_changes_layout=1
            '';

            programs.bash = {
                enable = true;
                enableCompletion = true;
                bashrcExtra = ''
                    [ $(command -v bleopt) ] && source ~/.config/ble.sh --noattach
                    prompt_symbol=${config.ethorbit.home-manager.bash.prompt.symbol}
                    PROMPT_ALTERNATIVE=${config.ethorbit.home-manager.bash.prompt.alternative}
                    NEWLINE_BEFORE_PROMPT=${config.ethorbit.home-manager.bash.prompt.newline}
                    source ~/.bashrc_text
                '';
            };
        };
    };
}
