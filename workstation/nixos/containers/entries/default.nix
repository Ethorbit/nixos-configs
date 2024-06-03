{ config, lib, makeEntry, ... }:

{
    imports = [
        (import ./selkies-gstreamer { inherit config; inherit lib; inherit makeEntry; })
    ];
}
