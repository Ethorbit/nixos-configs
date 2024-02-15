{ config, pkgs, ... }:

{
    #home-manager.users.${config.ethorbit.users.primary.username} = {
    #    home.file.nzc-docker = {
    #        source = (pkgs.fetchFromGitHub {
    #            owner = "Ethorbit";
    #            repo = "nzc-docker";
    #            rev = "master";
    #            hash = "sha256-TvIBXJ/KaEQ4ObbixplRbbyVX3IMaSJoXwjKVQIYX4g=";
    #        });
    #    };
    #};
}
