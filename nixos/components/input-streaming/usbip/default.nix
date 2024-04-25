{ config, pkgs, lib, ... }:

{
    environment.systemPackages = with pkgs; [
        linuxPackages.usbip
        ];

    boot.kernelModules = [ "usbip_core" "usbip_host" ];

    # Taken from https://gist.github.com/peedy2495/e9ed5938bf0c2e3983185d0c9622e97d
    systemd.services = {
        "usbip-attach@.service" = {
            description = "USB-IP Attaching on bus id %I";
            after = [ "network-online.target" ];
            wants = [ "network-online.target" ];
            environment.PATH = lib.mkForce "/run/wrappers/bin:/nix/profile/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin";

            serviceConfig = {
                Type = "forking";
                ExecStart = ''/bin/sh -c "host=$(echo %i|cut '-d_' -f1|tr -d '[:space:]'); dev=$(echo %i|cut '-d_' -f2|tr -d '[:space:]'); while true; do /usr/bin/lsusb | grep -q $dev; if [ $? -ne 0 ]; then busid=$(/usr/sbin/usbip list -p -r $host | grep $dev | cut '-d:' -f1 | xargs echo -n); /usr/sbin/usbip port|grep -q $dev; if [ $? -ne 0 ]; then /usr/sbin/usbip attach --remote=$host --busid=$busid; fi; fi; sleep 1; done;'';

                ExecStop = ''/bin/sh -c "dev=$(echo %i|cut '-d_' -f2|tr -d '[:space:]'); /usr/sbin/usbip port | while read i; do echo $i | grep -q $dev; if [ $? -eq 0 ]; then /usr/sbin/usbip detach --port=$port; fi; echo $i | grep -q Port; if [ $? -eq 0 ]; then port=$(echo $i | cut '-d ' -f2 | cut '-d:' -f1 | tr -d '[:space:]'); fi; done;'';
                
                Restart = "on-failure";
                RestartSec = 30;
            };

            wantedBy = [ "multi-user.target" ];
        };

        "usbip-export@.service" = {
            description = "USB-IP Binding on bus id %I";
            after = [ "network-online.target" "usbipd.service" ];
            wants = [ "network-online.target" ];
            environment.PATH = lib.mkForce "/run/wrappers/bin:/nix/profile/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin";
        
            serviceConfig = {
                Type = "forking";
                ExecStart = ''/usr/sbin/usbipd -D'';

                ExecStartPost = ''/bin/sh -c "dev=%i; statePrev=1; state=$(/usr/bin/lsusb|grep -q $dev; echo $?); while true; do if [ $state -ne $statePrev ]; then /usr/sbin/usbip bind --busid=$(/usr/sbin/usbip list -p -l | grep "$dev" | cut '-d#' -f1 | cut '-d=' -f2 | tr -d '[:space:]'); fi; sleep 1; statePrev=$state; state=$(/usr/bin/lsusb|grep -q $dev; echo $?); done &"'';

                ExecStop = ''/bin/sh -c "/usr/sbin/usbip unbind --busid=$(/usr/sbin/usbip list -p -l | grep "%i" | cut '-d#' -f1 | cut '-d=' -f2 | tr -d '[:space:]'); killall usbipd"'';

                Restart = "on-failure";
                RestartSec = 30;
            };

            wantedBy = [ "multi-user.target" ];
        };
    };
}
