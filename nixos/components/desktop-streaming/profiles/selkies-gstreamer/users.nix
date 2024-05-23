{ config, ... }:

{
    systemd.tmpfiles.rules = [
      "f /var/lib/systemd/linger/${config.ethorbit.components.selkies-gstreamer.settings.user}"
      #"d /etc/opt/VirtualGL 750 root vglusers -"
    ];
    #users.groups.vglusers = {};

    users.users."${config.ethorbit.components.selkies-gstreamer.settings.user}" = {
        # we enable linger so that a logon is not necessary for selkies gstreamer to start
        linger = true;

        extraGroups = [ "input" ]; # "vglusers"
    };
}
