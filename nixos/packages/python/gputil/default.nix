{ config, lib, pkgs, ... }:

with lib;
with pkgs;
{
    options = {
        ethorbit.pkgs.python.gputil = mkOption {
            type = types.package;
            default = (python3Packages.buildPythonPackage {
                pname = "gputil";
                version = "1.4.0";
                # It errors out about not finding a GPU, so skip the check.
                doCheck = false;
                description = "A Python module for getting the GPU status from NVIDA GPUs using nvidia-smi programmically in Python";
                src = (fetchFromGitHub {
                    owner = "anderskm";
                    repo = "gputil";
                    rev = "42ef071dfcb6469b7ab5ab824bde6ca9f6d0ab8a";
                    hash = "sha256-uzdo8fnaV0YftJe/+rnLz635mI8Buj6DIkB4iSNyIRo=";
                });
            });
        };
    };
}
