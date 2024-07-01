{ config, lib, ... }:

{
    options = {
        ethorbit.home-manager.zsh = with lib; {
            prompt = {
                colors = {
                    prompt = mkOption {
                        type = types.str;
                        default = "%B%F{cyan}";
                    };

                    name = mkOption {
                        type = types.str;
                        default = "${config.ethorbit.home-manager.zsh.prompt.colors.prompt}";
                    };

                    directory = mkOption {
                        type = types.str;
                        default = "%B%F{reset}";
                    };
                };
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

            programs.zsh = with lib; {
                enable = true;
                enableCompletion = true;
                syntaxHighlighting.enable = true;
                # 1. Why do people change variable names without adding backwards compatibility?
                # 2. Why does nix not allow us to check if an option exists before setting it?
                # Comment the one that causes the error. \o/
                #autosuggestion.enable = true;
                enableAutosuggestions = true;
                history = {
                    share = true;
                    ignoreDups = true;
                    ignoreSpace = true;
                    expireDuplicatesFirst = true;
                };
                autocd = true;
                initExtra = ''
                    prompt_color=${config.ethorbit.home-manager.zsh.prompt.colors.prompt}
                    name_color=${config.ethorbit.home-manager.zsh.prompt.colors.name}
                    dir_color=${config.ethorbit.home-manager.zsh.prompt.colors.directory}
                    prompt_symbol=${config.ethorbit.home-manager.shell.prompt.symbol}
                    PROMPT_ALTERNATIVE=${config.ethorbit.home-manager.shell.prompt.alternative}
                    NEWLINE_BEFORE_PROMPT=${config.ethorbit.home-manager.shell.prompt.newline}
                    source ~/.zshrc_text
                '';
            };
        };
    };
}
