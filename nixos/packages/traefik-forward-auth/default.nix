{ config, lib, pkgs, ... }:

with pkgs;
with lib;

let
    version = "2.3.0";
in
{
    options.ethorbit.pkgs.traefik-forward-auth = mkOption {
        type = types.package;
        default = (stdenv.mkDerivation {
            name = "traefik-forward-auth";
            description = "Minimal forward authentication service that provides Google/OpenID oauth based login and authentication for the traefik reverse proxy.";
            src = fetchurl {
                url = "https://github.com/thomseddon/traefik-forward-auth/releases/download/v${version}/traefik-forward-auth_amd64";
                sha256 = "sha256-U51zPxA3s+9ZMIgKWhq8pAgfz3LW+ruBDcW0p624F1E=";
            };

            phases = [ "installPhase" ];

            installPhase = ''
                install -D $src $out/bin/traefik-forward-auth
            '';
       });
    };
}
