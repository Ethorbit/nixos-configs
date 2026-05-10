# Copyfail CVE-2026-31431 root escalation defense
# https://discourse.nixos.org/t/is-nixos-affected-by-copy-fail-edit-yes-it-is/77317

{ pkgs, lib, ... }:

{
    boot.blacklistedKernelModules = [
        # Protect against Copyfail
        "af_alg"
        "algif_hash"
        "algif_skcipher"
        "algif_rng"
        "algif_aead"
        # Protect against Dirty Frag
        # https://youtu.be/AsoBmy-Hcxc?si=YQ_bs1ZbRAoJTCsp&t=155
        "esp4"
        "esp6"
        "rxrpc"
        "ipcomp4"
        "ipcomp6"
    ];

    # Upgrade to a safe kernel
    boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "6.18.22") (
        lib.mkDefault pkgs.linuxPackages_6_18
    );  
}
