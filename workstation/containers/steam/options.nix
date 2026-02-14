{ config, lib, ... }:

with lib;

let
    cfg = config.ethorbit.workstation.container.steam;
in
{
    options.ethorbit.workstation.container.steam = {
        name = mkOption {
            description = ''The name of the container that primarily runs steam'';
            type = types.str;
            default = "steam";
        };

        username = mkOption {
            description = ''The username that steam will run under'';
            type = types.str;
            default = "steam";
        };

        uid = mkOption {
            type = types.int;
            description = ''The UID the steam user will have'';
            default = config.users.users."${config.ethorbit.users.primary.username}".uid;
        };

        commands = {
            link = mkOption {
                description = ''Host command to delete the network for this container'';
                type = types.str;
                default = "sudo ip link delete vb-${cfg.name}";
            };

            stop = mkOption {
                description = ''Host command to stop this container'';
                type = types.str;
                default = "sudo nixos-container stop ${cfg.name}";
            };

            start = mkOption {
                description = ''Host command to start this container'';
                type = types.str;
                default = "sudo nixos-container start ${cfg.name}";
            };

            run = mkOption {
                description = ''Run a command in this container'';
                type = types.functionTo types.str;
                default = c: "sudo nixos-container run ${cfg.name} -- su ${cfg.username} -c 'cd ~/ && ${c}'";
            };
        };

        debug = mkOption {
            description = ''Whether or not the container is in debugging mode'';
            default = true;
        };

        gamescope = {
            display = mkOption {
                description = ''
                    Currently there's no way to control which socket gamescope creates
                    (We'd have to patch it and add a --nested-display)
                    For now, we'll assume what it will be based on how many displays we have running.
                    1 display at :0 means gamescope will open :1, so :1 is the safest default.
                '';
                type = types.int;
                default = 1;
                example = 99;
            };
        };
    };
}
