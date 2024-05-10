{ config, pkgs, lib, ... }:

{
    options = {
        ethorbit.pkgs.selkies-gstreamer = with pkgs; with lib; mkOption {
            type = types.package;
            default = (python3Packages.buildPythonPackage {
                pname = "selkies-gstreamer";
                version = "1.5.2";
                format = "wheel";
                src = fetchurl {
                    url = "https://github.com/selkies-project/selkies-gstreamer/releases/download/v1.5.2/selkies_gstreamer-1.5.2-py3-none-any.whl";
                    sha256 = "sha256-OO3b9pjljZO2t5ITuXnK4yPSnJghQlN+OouM0BQ9a8U=";
                };
            });
        };
    };

    config = { 
        environment.systemPackages = [ config.ethorbit.pkgs.selkies-gstreamer ];
    };
}
