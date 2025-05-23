{ config, lib, ... }:

{
    # The option definition `hardware.opengl.driSupport' no longer has any effect; please remove it.
    config = lib.mkIf (config.system.nixos.release < "24.11") {
        hardware.opengl = {
            enable = true;
            driSupport = true;
            driSupport32Bit = lib.mkDefault true;
        };
    };
}
