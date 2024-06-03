{ config, makeEntry, lib, ... }:

{
    ethorbit.workstation.containers.entries."development" = (makeEntry {
        ip = "172.12.1.220";
        label = "selkies-gstreamer";
        imports = [ ./config ./development ];
        # To allow Docker to work
        extraFlags = [
            "--system-call-filter=add_key"
            "--system-call-filter=keyctl"
            "--system-call-filter=bpf"
        ];
    });
}
