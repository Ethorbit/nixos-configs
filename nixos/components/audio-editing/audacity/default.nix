{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # Audacity, but with useful plugins
        (symlinkJoin {
            name = "audacity-wrapped";
            paths = [ audacity ];
            nativeBuildInputs = [ makeWrapper ];
            postBuild = ''
                wrapProgram $out/bin/audacity \
                    --prefix LV2_PATH : "${lsp-plugins}/lib/lv2:${calf}/lib/lv2"
            '';
        })
    ];
}
