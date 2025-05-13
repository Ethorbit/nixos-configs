{ config, lib, pkgs, ... }:

with lib;
with pkgs;

let
    name = "obs-pulseaudio-app-capture";
    version = "v0.2.0-alpha";
    description = "OBS plugin to capture application audio from PulseAudio";
in
{
    options = {
        ethorbit.pkgs.c.obs-pulseaudio-app-capture = mkOption {
            type = types.package;
            default = (stdenv.mkDerivation {
                inherit name version description;
                pname = name;

                src = (fetchFromGitHub {
                    owner = "jbwong05";
                    repo = "obs-pulseaudio-app-capture";
                    rev = "${version}";
                    sha256 = "sha256-AJNcSvJBmVfm+7AqvWCBoZ8e/6kwQSvibAYdv0vNwlc=";
                });

                nativeBuildInputs = [
                    cmake
                    zsh
                    obs-studio
                    qt6.full
                ];

                propagatedBuildInputs = [
                    libpulseaudio
                ];
            });
        };
    };
}
