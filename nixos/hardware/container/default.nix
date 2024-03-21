{ config, lib, ... }:

{
    ethorbit.system.container = lib.mkDefault "yes";
    boot.isContainer = true;
}
