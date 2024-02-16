{ config, lib, pkgs, ... }:

{
    options = with lib; {
        ethorbit.scripts.nzc.gitclone = mkOption {
            type = types.package;
            default = (pkgs.writeShellScript "nzc-git-clone.sh" ''
                git="${pkgs.git}/bin/git"
                repo="https://github.com/Ethorbit/nzc-docker.git"
                
                cd "$HOME"

                if [ ! "$(ls -A ./nzc-docker)" ]; then
                    "$git" clone "$repo" ./nzc-docker
                fi
            '');
        };
    };

    config = {
        systemd.user.services."git-clone-nzc-docker" = {
            enable = true;
            description = "Clones the nzc-docker git repository.";
            serviceConfig = {
                Type = "simple";
                ExecStart = ''"${config.ethorbit.scripts.nzc.gitclone.outPath}"'';
            };
            wantedBy = [ "default.target" ];
        };
    };
}
