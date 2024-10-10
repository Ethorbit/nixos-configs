{ config, ... }:

{
    imports = [
        ../bubblewrap-fix
    ];

    services.flatpak = {
        enable = true;
        packages = [];
    };
}
