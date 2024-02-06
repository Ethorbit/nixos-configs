{ config, lib, pkgs, ... }:

{
    options = with lib; {
        ethorbit.polybar.scripts.mocp.toggle-play = lib.mkOption {
            type = types.package;
            default = (pkgs.writeShellScript "mocp-toggle-play.sh" ''
                STATE=$("${config.ethorbit.polybar.scripts.mocp.state.outPath}")

                case $STATE in
                    STOP)
                    echo ""
                    ;;
                    PAUSE)
                    echo ">"
                    ;;
                    PLAY)
                    echo "||"
                    ;;
                esac
            '');
        };
    };
}
