{ ... }:

{
    home-manager = {
        sharedModules = [ {
            ethorbit.home-manager = {
                shell.prompt.symbol = "☠";
                zsh.prompt = {
                    colors = {
                        prompt = "%B%F{red}";
                        name = "%B%F{red}";
                    };
                };
            };
        } ];
    };
}
