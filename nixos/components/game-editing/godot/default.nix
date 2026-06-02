{ config, ... }:

{
    imports = [
        ../.
    ];

    environment.systemPackages = with config.ethorbit.components.gamedev.packages; [
        godot-mono
        (pkgs.runCommand "godot-symlink" {} ''
            mkdir -p $out/bin
            ln -s ${godot-mono}/bin/godot-mono $out/bin/godot
        '')
    ];
}
