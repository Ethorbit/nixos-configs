# Based on https://gist.github.com/peedy2495/e9ed5938bf0c2e3983185d0c9622e97d
{ config, pkgs, lib, ... }:

let
    serviceScripts = {
        attach = {
            start = pkgs.writeShellScriptBin "script" ''
            ARG="$@"
            host=$(echo $ARG|cut '-d_' -f1|tr -d '[:space:]')
            dev=$(echo $ARG|cut '-d_' -f2|tr -d '[:space:]')
            while true; do
                lsusb | grep -q $dev
                if [ $? -ne 0 ]; then
                    busid=$(usbip list -p -r $host | grep $dev | cut '-d:' -f1 | xargs echo -n)
                    usbip port|grep -q $dev
                    if [ $? -ne 0 ]; then
                        usbip attach --remote=$host --busid=$busid
                    fi
                fi
                sleep 1
            done
            '';

            stop = pkgs.writeShellScriptBin "script" ''
            ARG="$@"
            dev=$(echo $ARG|cut '-d_' -f2|tr -d '[:space:]')
            usbip port | while read i; do
                echo $i | grep -q $dev
                if [ $? -eq 0 ]; then
                    usbip detach --port=$port
                fi
                echo $i | grep -q Port
                if [ $? -eq 0 ]; then
                    port=$(echo $i | cut '-d ' -f2 | cut '-d:' -f1 | tr -d '[:space:]')
                fi
            done           
            '';
        };

        export = {
            start = pkgs.writeShellScriptBin "script" ''
            usbipd -D
            '';

            startPost = pkgs.writeShellScriptBin "script" ''
            ARG="$@"
            dev=$ARG
            statePrev=1
            state=$(lsusb|grep -q $dev; echo $?)
            while true; do
                if [ $state -ne $statePrev ]; then
                    usbip bind --busid=$(usbip list -p -l | grep "$dev" | cut '-d#' -f1 | cut '-d=' -f2 | tr -d '[:space:]')
                fi
                sleep 1
                statePrev=$state
                state=$(lsusb|grep -q $dev; echo $?)
            done
            '';

            stop = pkgs.writeShellScriptBin "script" ''
            ARG="$@" 
            usbip unbind --busid=$(usbip list -p -l | grep "$ARG" | cut '-d#' -f1 | cut '-d=' -f2 | tr -d '[:space:]')
            killall usbipd
            '';
        };
    };
in
{
    systemd.services = {
        "usbip-attach@" = {
            description = "USB-IP Attaching on bus id %I";
            after = [ "network-online.target" ];
            wants = [ "network-online.target" ];
            environment.PATH = lib.mkForce "${config.system.path}/bin";

            serviceConfig = {
                Type = "forking";
                ExecStart = ''${serviceScripts.attach.start}/bin/script %i'';
                ExecStopPost = ''${serviceScripts.attach.stop}/bin/script %i'';
                Restart = "on-failure";
                RestartSec = 30;
            };

            wantedBy = [ "multi-user.target" ];
        };

        "usbip-attach@multi-user" = {
            enable = false;
        };

        "usbip-export@" = {
            description = "USB-IP Binding on bus id %I";
            after = [ "network-online.target" ];
            wants = [ "network-online.target" ];
            environment.PATH = lib.mkForce "${config.system.path}/bin";

            serviceConfig = {
                Type = "forking";
                ExecStart = ''${serviceScripts.export.start}/bin/script %i'';
                ExecStartPost = ''${serviceScripts.export.startPost}/bin/script %i'';
                ExecStop = ''${serviceScripts.export.stop}/bin/script %i'';
                Restart = "on-failure";
                RestartSec = 30;
            };

            wantedBy = [ "multi-user.target" ];
        };

        "usbip-export@multi-user" = {
            enable = false;
        };

    };
}
