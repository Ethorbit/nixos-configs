{
    # Copyfail vulnerability protection
    # https://discourse.nixos.org/t/is-nixos-affected-by-copy-fail-edit-yes-it-is/77317
    # Protect against the copy fail exploit by blacklisting the affected kernel modules
    boot.blacklistedKernelModules = [
        "af_alg"
        "algif_hash"
        "algif_skcipher"
        "algif_rng"
        "algif_aead"
    ];
}
