{ config, lib, pkgs, ... }:

{
    options = {
        ethorbit.pkgs.vimPlugins.synthweave = with pkgs; with lib; mkOption {
            type = types.package;
            default = (stdenv.mkDerivation {
                name = "synthweave";
                src = (fetchFromGitHub {
                    owner = "samharju";
                    repo = "synthweave.nvim";
                    rev = "50cb17af14dbdf8a2af634c40b9b20298f67aba0";
                    hash = "sha256-kxfTnmzUnF2tgBf1Ic/3xNWeEffbsKEyxxNXPV4bTbQ=";
                });
                installPhase = ''
                    cp -rap "$src/" "$out/"
                '';
           });
        };
    };
}
