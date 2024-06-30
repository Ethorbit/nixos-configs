{ config, lib, ... }:

{
    options.ethorbit.home-manager.zsh = with lib; {
        prompt = {
            color = mkOption {
                type = types.str;
                default = "%B%F{cyan}";
            };

            colorinfo = mkOption {
                type = types.str;
                default = "${config.ethorbit.home-manager.zsh.prompt.color}";
            };
        };
    };

    config = {
        home-manager.users.${config.ethorbit.users.primary.username} = {
            # so nix can stay TF outta my way and stop trying to parse properly escaped text
            # (seriously, sometimes nix is just a headache!)
            home.file.".zshrc_text" = {
                source = ./.zshrc;
                recursive = true;
            };

            programs.zsh = {
                enable = true;
                initExtra = ''
                    prompt_color=${config.ethorbit.home-manager.zsh.prompt.color}
                    info_color=${config.ethorbit.home-manager.zsh.prompt.colorinfo}
                    prompt_symbol=${config.ethorbit.home-manager.shell.prompt.symbol}
                    PROMPT_ALTERNATIVE=${config.ethorbit.home-manager.shell.prompt.alternative}
                    NEWLINE_BEFORE_PROMPT=${config.ethorbit.home-manager.shell.prompt.newline}
                    source ~/.zshrc_text
                '';
            };
        };
    };
}
