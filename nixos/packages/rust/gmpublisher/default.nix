# It builds correctly, but during runtime
# it wants libsteam and I don't know how
# to provide it that, so I give up now 
# and am creating a Flatpak

{ config, lib, pkgs, ... }:

with pkgs;
with lib;

let
    version = "2.10.4";
    pname = "gmpublisher";
    description = ''Workshop Publishing Utility for Garry's Mod, written in Rust & Svelte and powered by Tauri'';
    src = (fetchFromGitHub {
        owner = "WilliamVenner";
        repo = "gmpublisher";
        rev = "${version}";
        hash = "sha256-iYrqBcwKqXDUQMgMDGTztbKVob9Tnf30/LaR6OISSYA=";
    });

    gmpublisher = (rustPlatform.buildRustPackage {
        inherit src pname description version;
        name = pname;

        npmDeps = fetchNpmDeps {
            name = "${pname}-npm-deps-${version}";
            inherit src;
            hash = "sha256-b3j123UVfbhff/9Xbn/7u0Nud8gWWAawstX0tqDb9Ys=";
        };

        cargoRoot = "src-tauri";
        cargoHash = "sha256-80njyllFItnVwXBsbuxjyZ0tuBDDC6XMIa6St5qe/eo=";
        buildAndTestSubdir = "src-tauri";

        nativeBuildInputs = [
            # Pull in our main hook
            cargo-tauri

            # Setup npm
            nodejs
            npmHooks.npmConfigHook

            # Make sure we can find our libraries
            pkg-config
            wrapGAppsHook3

            steam
        ];

        buildInputs = [
            openssl
            glib-networking # Most Tauri apps need networking
            libsoup
            unstable.webkitgtk_4_0
        ];
    });

    desktop = (pkgs.makeDesktopItem {
        name = pname;
        desktopName = "GMPublisher";
        exec = "${gmpublisher}/bin/gmpublisher %f";
        terminal = false;
    });
in
{
    options.ethorbit.pkgs.rust.gmpublisher = mkOption {
        inherit description;
        type = types.package;
        default = desktop;
    };
}
