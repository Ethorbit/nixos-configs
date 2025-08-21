{ config, lib, ... }:

with lib;

{
   networking.hosts = {
       "127.0.0.1" = [ "host" ];
   };
}
