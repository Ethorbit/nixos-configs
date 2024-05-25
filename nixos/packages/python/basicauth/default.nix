{ config, lib, pkgs, ... }:

with lib;
with pkgs;
{
    options = {
        ethorbit.pkgs.python.basicauth = mkOption {
            type = types.package;
            default = (python3Packages.buildPythonPackage {
                pname = "basicauth";
                version = "1.0.0";
                description = "An incredibly simple HTTP basic auth implementation.";
                src = (fetchFromGitHub {
                    owner = "rdegges";
                    repo = "python-basicauth";
                    rev = "bccbe82ba961674b83f853bf141c7bf509198bf2";
                    hash = "sha256-W7aPYUbbskTGzJdL5aCb1aOFRWPEF2ZuKZZFw4AYIoE=";
                });
            });
        };
    };
}
