{ config, lib, pkgs, ... }:

{
    options = {
        ethorbit.pkgs.vimPlugins.confirm-quit = with pkgs; with lib; mkOption {
            type = types.package;
            default = (stdenv.mkDerivation {
                name = "confirm-quit";
                src = (fetchFromGitHub {
                    owner = "vim-scripts";
                    repo = "confirm-quit";
                    rev = "master";
                    hash = "sha256-s1mZoZlc8vbgA1X43fXVz+cixSWcFbhkfMJL2a1hrhs=";
                });
                installPhase = ''
                    ls -laht "$src/"
                    cp -rap "$src/" "$out/"
                '';
           });
        };
    };
}
