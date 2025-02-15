# Disk decrypt script, since we have a virtual keyboard we cannot do the
# traditional full-disk encryption :(
#
# Based on my documentation I made for encrypting SteamOS:
# https://github.com/Ethorbit/SteamDeck-SteamOS-Guides/tree/main/Encrypting-With-LUKS

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

            if [[ "$1" = "proceed" ]]; then
                # Kill any processes trying to write to /home
                for pid in $(${lsof}/bin/lsof +D /home | grep 'w' | awk '{print $2}'); do
                    ${coreutils-full}/bin/kill -9 "$pid"
                done

                # Unmount /home
                ${umount}/bin/umount /home 2> /dev/null

                if [[ $(grep /home /proc/mounts) ]]; then
                    echo "Unmounting /home failed, it will be lazily unmounted instead."
                    ${umount}/bin/umount -l /home 2> /dev/null
                fi

                # Mount our encrypted stuff
                "$mount_pass_script"
                "$unlock_key_script"
                "$mount_key_script"

                # Restart systemd and its services
                ${systemd}/bin/systemctl daemon-reexec
                ${systemd}/bin/systemctl isolate default.target

                # Kill all user processes
                sleep 2
                pkill -u $(who | awk '{print $1}' | sort -u)
            else
                cd /tmp
                ${coreutils-full}/bin/nohup "$0" proceed > /dev/null 2>&1
            fi
        '');
    };

    config = {
        environment.systemPackages = with pkgs; [
            config.ethorbit.steamdeck.packages.decrypt.script
        ];
    };
}
