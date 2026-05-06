# Copyfail CVE-2026-31431 root escalation defense
# https://discourse.nixos.org/t/is-nixos-affected-by-copy-fail-edit-yes-it-is/77317

{ pkgs, lib, ... }:

{
    # Protect against the exploit by blacklisting the affected kernel modules
    boot.blacklistedKernelModules = [
        "af_alg"
        "algif_hash"
        "algif_skcipher"
        "algif_rng"
        "algif_aead"
    ];

    # Upgrade to a safe kernel
    boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "6.18.22") (
        lib.mkDefault pkgs.linuxPackages_6_18
    );  
}
