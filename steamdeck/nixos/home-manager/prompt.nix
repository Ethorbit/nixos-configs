{ config, ... }:

{
    ethorbit.home-manager = {
        shell.prompt.symbol = ''◑'';
        zsh.prompt.colors = {
            prompt = "%F{4}";
        };
    };
}
