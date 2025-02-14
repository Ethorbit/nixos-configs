{ config, lib, pkgs, ... }:

with lib;
with pkgs;

let
    version = "1.0.5";
in
{
    options = {
        ethorbit.pkgs.python.watch-xfce-xfconf = mkOption {
            type = types.package;
            default = with python312Packages; (buildPythonPackage {
                pname = "watch-xfce-xfconf";
                version = "${version}";
                doCheck = false;
                description = ''watch-xfce-xfconf: Configure XFCE 4 programmatically using the xfconf-query commands displayed by watch-xfce-xfconf'';
                src = (fetchFromGitHub {
                    owner = "jamescherti";
                    repo = "watch-xfce-xfconf";
                    rev = "v${version}";
                    hash = "sha256-CkKZ8ro2nZJ5h8Vxa9xvuMgiIgp6mWC4jIQWAX2xMO4=";
                });
                propagatedBuildInputs = [
                    psutil
                    lxml
                ];
            });
        };
    };
}
