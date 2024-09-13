#!/usr/bin/env bash
nix-shell -E 'with import <nixpkgs> {}; callPackage ./derivation.nix {}' -A make-deps --run 'eval "$makeDeps"'
