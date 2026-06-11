{ ... }:

{
    home-manager.sharedModules = [ {
        ethorbit.home-manager = {
            shell.prompt.symbol = ''◑'';
        };
    } ];
}
