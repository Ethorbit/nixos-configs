{ config, lib, pkgs, ... }:

{
    options = with lib; {
        ethorbit.polybar.scripts.mocp.state = lib.mkOption {
            type = types.package;
            default = (pkgs.writeShellScript "mocp-state.sh" ''
                mocp="${pkgs.moc}/bin/mocp"
                awk="${pkgs.gawk}/bin/awk"
                cut="${pkgs.gash-utils}/bin/cut"
                tr="${pkgs.gash-utils}/bin/tr"
                STATE=$("$mocp" -i | "$awk" 'NR==1' | "$cut" -d ':' -f 2 | "$tr" -d ' ')
                echo "$STATE"
            '');
        };
    };
}
