# Unlock LUKS devices using the keyfiles
{ config, lib, pkgs, ... }:

with lib;
with pkgs;

{
    options.ethorbit.steamdeck.packages.decrypt.unlock-key = mkOption {
        type = types.package;
        default = (pkgs.writeShellScript "script" ''
            ${cryptsetup}/bin/cryptsetup luksOpen \
                /dev/disk/by-uuid/c29abde6-8237-410e-a338-f808ff065c99 \
                --key-file /key/unlockkey \
                crypt_sdcard
        '');
    };
}
