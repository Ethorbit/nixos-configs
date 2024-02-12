{ config, pkgs, ... }:

let
    command_no_process = (pkgs.writeShellScriptBin "command_no_process" ''
        pgrep_path="${pkgs.procps}/bin/pgrep"
        process_name="$1"
        run_command="$2"

        if [[ ! $("$pgrep_path" "$process_name") ]]; then
            "$run_command"
        fi
    '');
in
{
    imports = [
        ../../services/feh/wallpaper
    ];

    systemd.user.services."window-manager-once" = {
        enable = true;
        description = "Manages the window manager on first start";
        script = ''
            [ -f "$HOME/.desktop-once" ] && source "$HOME/.desktop-once"
        '';
    };

    systemd.user.services."window-manager-always" = {
        enable = true;
        description = "Manages the window manager on start and reload";
        script = ''
            #command_no_process="${command_no_process.outPath}/bin/command_no_process"
            # $command_no_process 'process-name' 'comnand to run process' # keep process running at all times
            [ -f "$HOME/.desktop-always" ] && source "$HOME/.desktop-always"
        '';
        wants = [
            "spice-vdagent.service"
            "feh-desktop-wallpaper.service"
            "polybar.service"
            "flameshot.service"
            "dunst.service"
            "picom.service"
        ];
    };
}
