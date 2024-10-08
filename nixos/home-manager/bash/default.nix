{ config, lib, ... }:

{
    options.ethorbit.home-manager.bash = with lib; {
        prompt = {
            color = mkOption {
                type = types.str;
                default = "\\\\[\\\\e[36m\\\\]";
            };

            colorinfo = mkOption {
                type = types.str;
                default = "${config.ethorbit.home-manager.bash.prompt.color}";
            };
        };
    };

    config = {
        home-manager.sharedModules = [ {
            # so nix can stay TF outta my way and stop trying to parse properly escaped text
            # (seriously, sometimes nix is just a headache!)
            home.file.".bashrc_text" = {
                source = ./.bashrc;
                recursive = true;
            };

            home.file.".config/ble.sh".text = lib.mkDefault ''
                bleopt editor=$${EDITOR}
                bleopt prompt_command_changes_layout=1
                bleopt complete_auto_delay=300
                bleopt history_share=1
            '';

            programs.bash = {
                enable = true;
                enableCompletion = true;
                bashrcExtra = ''
                    [ $(command -v bleopt) ] && source ~/.config/ble.sh --noattach
                    prompt_color=${config.ethorbit.home-manager.bash.prompt.color}
                    info_color=${config.ethorbit.home-manager.bash.prompt.colorinfo}
                    prompt_symbol=${config.ethorbit.home-manager.shell.prompt.symbol}
                    PROMPT_ALTERNATIVE=${config.ethorbit.home-manager.shell.prompt.alternative}
                    NEWLINE_BEFORE_PROMPT=${config.ethorbit.home-manager.shell.prompt.newline}
                    source ~/.bashrc_text
                '';
            };
        } ];
    };
}
