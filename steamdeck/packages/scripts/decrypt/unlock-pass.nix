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
                /root/key_container \
                crypt_key
        '');
    };
}
