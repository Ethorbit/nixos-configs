{ config, lib, pkgs, ... }:

with lib;
with pkgs;

let
    version = "0.10.0";
in
{
    options = {
        ethorbit.pkgs.python.steam-acolyte = mkOption {
            type = types.package;
            default = with python312Packages; (buildPythonPackage {
                pname = "steam-acolyte";
                version = "${version}";
                doCheck = false;
                description = ''Lightweight Steam Account Switcher'';
                src = (fetchFromGitHub {
                    owner = "coldfix";
                    repo = "steam-acolyte";
                    rev = "v${version}";
                    hash = "sha256-ZVvuEvoXUmmUoOZJPLDVbQ7XvplP3ezhD6lhS0WfjiQ=";
                });
                propagatedBuildInputs = [
                    pyqt5
                    vdf
                    docopt
                    importlib-resources
                    qt5.full
                ];
            });
        };
    };
}
