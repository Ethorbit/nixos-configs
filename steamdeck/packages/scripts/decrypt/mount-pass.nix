# Mount LUKS devices which were unlocked by a passphrase
{ config, lib, pkgs, ... }:

with lib;
with pkgs;

{
    options.ethorbit.steamdeck.packages.decrypt.mount-pass = mkOption {
        type = types.package;
        default = (pkgs.writeShellScript "script" ''
            ${coreutils-full}/bin/mkdir /key
            ${mount}/bin/mount /dev/mapper/crypt_key /key
        '');
    };
}
