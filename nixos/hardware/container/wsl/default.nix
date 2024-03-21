{ config, ... }:

{
    imports = [
        ../.
    ];

    ethorbit.system.container = "wsl";

    wsl = {
        enable = true;
        defaultUser = config.ethorbit.users.primary.username;
    };
}
