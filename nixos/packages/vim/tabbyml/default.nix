{ config, lib, pkgs, ... }:

{
    options = {
        ethorbit.pkgs.vimPlugins.tabbyml = with pkgs; with lib; mkOption {
            type = types.package;
            default = (stdenv.mkDerivation {
                name = "tabbyml";
                src = (fetchFromGitHub {
                    owner = "TabbyML";
                    repo = "vim-tabby";
                    rev = "master";
                    hash = "sha256-evT7xF6J289xSRUhMMKN+5c37pxCYCCdNpqAzzfsmRk=";
                });
                installPhase = ''
                    ls -laht "$src/"
                    cp -rap "$src/" "$out/"
                '';
           });
        };
    };
}
