{ config, lib, pkgs, ... }:

{
    options = with lib; {
        ethorbit.polybar.scripts.memory-available = lib.mkOption {
            type = types.package;
            default = (pkgs.writeShellScript "memory-available.sh" ''
                "${pkgs.procps}/bin/free" -h | "${pkgs.gash-utils}/bin/awk" '{ print $7 }' | "${pkgs.gash-utils}/bin/awk" 'NR==2 { print $1 }'
            '');
        };
    };
}

