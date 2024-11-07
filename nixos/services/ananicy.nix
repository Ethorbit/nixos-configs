{ config, lib, pkgs, ... }:

with lib;
with pkgs;

{
    services.ananicy = {
        # ananicy was archived in 2023 and ananicy-cpp is a newer
        # and faster rewrite of ananicy.
        #
        # this is why I have changed the default to ananicy-cpp
        #
        # If you change these, you'll need to add support for
        # the ananicy rules in the components for them to work
        # as intended
        package = mkDefault ananicy-cpp;
        rulesProvider = mkDefault (stdenv.mkDerivation {
            name = "custom-ananicy-provider";
            phases = [ "installPhase" ];
            installPhase = ''
                mkdir -p $out

                # Add default rules
                cp -Rap "${ananicy-rules-cachyos.outPath}/etc/ananicy.d"/* "$out"/

                # Make sure our extraRules can override what's in the defaults
                mv "$out/00-default" "$out/99-default"
                mv "$out/00-types.types" "$out/99-types.types"
                mv "$out/00-cgroups.cgroups" "$out/99-cgroups.cgroups"
                ln -sf /etc/static/ananicy.d/nixRules.rules $out/00-nixRules.rules
            '';
        });
        #mkDefault ananicy-rules-cachyos;
        settings = {
            "check_freq" = mkDefault 5;
        };
    };
}
