{ config, ... }:

{
    imports = [
        ../.
    ];

    environment.systemPackages = with config.ethorbit.components.gamedev.packages; [
        vpkedit
        vtfedit
    ];
}
