# Since I guess the libnice in nixpkgs only offers two binaries (wtf?)
# I will need to build it myself to get the actual stuff.
# At the time of writing, I specifically need the gstreamer lib/
{ config, lib, pkgs, ... }:

with pkgs;
with lib;
{
    options.ethorbit.pkgs.libnice = mkOption {
        type = types.package;
        default = stdenv.mkDerivation {
            name = "libnice";
            src = fetchFromGitHub {
                owner = "libnice";
                repo = "libnice";
                rev = "2c72599dd71bbc9ef9ec4aaf8f5dbda50e9833c1";
                hash = "sha256-Yq5n37YtKLvR1xlfH67AEculwHTU6JQrUr74E0poM/s=";
            };
            mesonFlags = [
                "-Dgtk_doc=${if (stdenv.buildPlatform == stdenv.hostPlatform) then "enabled" else "disabled"}"
                "-Dintrospection=${if (stdenv.buildPlatform == stdenv.hostPlatform) then "enabled" else "disabled"}"
                "-Dexamples=disabled" # requires many dependencies and probably not useful for our users
            ];
            nativeBuildInputs = [
                meson
                ninja
                pkg-config
                python3
                gobject-introspection

                # documentation
                gtk-doc
                docbook_xsl
                docbook_xml_dtd_412
                graphviz
            ];
            buildInputs = [
                gst_all_1.gstreamer
                gst_all_1.gst-plugins-base
                gnutls
                gupnp-igd
            ];
            propagatedBuildInputs = [
                glib
            ];
        };
    };
}
