# Unlock LUKS devices using passphrases
{ config, lib, pkgs, ... }:

with lib;
with pkgs;

{
    options.ethorbit.steamdeck.packages.decrypt.unlock-pass = mkOption {
        type = types.package;
        default = (pkgs.writeShellScript "script" ''
            ${cryptsetup}/bin/cryptsetup luksOpen \
                --allow-discards \
                /dev/disk/by-uuid/c8524068-ad7b-43f9-b787-27d5b40d98e4 \
                crypt_key
        '');
    };
}
