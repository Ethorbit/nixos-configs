# Disk decrypt script, since we have a virtual keyboard we cannot do the
# traditional full-disk encryption :(
#
# Based on my documentation I made for encrypting SteamOS:
# https://github.com/Ethorbit/SteamDeck-SteamOS-Guides/tree/main/Encrypting-With-LUKS
# Except I improved it since it was kinda broken anyway
#
# It's not foolproof, but it's the best thing I can write without going insane

{ config, pkgs, lib, ... }:

with pkgs;
with lib;

{
    imports = [
        ./unlock-pass.nix
        ./mount-pass.nix
        ./unlock-key.nix
        ./mount-key.nix
    ];

    options.ethorbit.steamdeck.packages.decrypt.script = mkOption {
        type = types.package;
        default = (pkgs.writeShellScriptBin "decrypt.sh" ''
            readonly unlock_pass_script="${config.ethorbit.steamdeck.packages.decrypt.unlock-pass.outPath}"
            readonly mount_pass_script="${config.ethorbit.steamdeck.packages.decrypt.mount-pass.outPath}"
            readonly unlock_key_script="${config.ethorbit.steamdeck.packages.decrypt.unlock-key.outPath}"
            readonly mount_key_script="${config.ethorbit.steamdeck.packages.decrypt.mount-key.outPath}"

            readonly argument="$1"
            # set -uo pipefail

            if [[ $(id -u) -ne 0 ]]; then 
               echo "You need root"
               exit
            fi

            for file in "$unlock_pass_script" "$mount_pass_script" \
                "$unlock_key_script" "$mount_key_script"; do
                if [[ ! -f "$file" ]]; then 
                    echo "$file is missing."
                    exit
                fi
            done

            "$unlock_pass_script"

            case $? in
                0|5) # succeeded or mapper device already exists
                ;;
                *) # failure?
                  exit $?
                ;;
            esac

            if [[ "$argument" = "proceed" ]]; then
                # Pause all active processes of the primary user, and queue them to die when this script finishes
                pkill -STOP -u "${config.ethorbit.users.primary.username}"
                trap 'pkill -KILL -u "${config.ethorbit.users.primary.username}"' EXIT
                sleep 1

                # Unmount /home (with 5 attempts)
                for i in {1..5}; do
                    ${umount}/bin/umount -f /home 2> /dev/null
                    sleep 1
                    grep -q "/home" /proc/mounts || break
                done
                
                # If attempts to unmount failed, lazily unmount instead (This is cursed)
                if grep -q "/home" /proc/mounts 2>/dev/null; then
                    echo "Unmounting /home failed, it will be lazily unmounted instead."
                    ${umount}/bin/umount -l /home 2> /dev/null
                fi

                sleep 2

                # Mount our encrypted stuff
                "$mount_pass_script"
                "$unlock_key_script"
                "$mount_key_script"
                sleep 2

                # Restart systemd and its services
                ${systemd}/bin/systemctl daemon-reexec
                ${systemd}/bin/systemctl isolate default.target
            else
                cd /tmp
                ${coreutils-full}/bin/nohup "$0" proceed > /dev/null 2>&1 & disown
            fi
        '');
    };

    config = {
        environment.systemPackages = with pkgs; [
            config.ethorbit.steamdeck.packages.decrypt.script
        ];
    };
}
