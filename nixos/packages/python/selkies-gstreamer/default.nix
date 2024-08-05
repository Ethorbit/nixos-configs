# TODO: Add the Selkies-Gstreamer Joystick Interposer soon.

{ config, pkgs, lib, ... }:

with pkgs;
with lib;

let
    version = "1.6.0";
in
{
    imports = [
        ../gputil
        ../basicauth
    ];

    options = {
        ethorbit.pkgs.python.selkies-gstreamer-web = mkOption {
            type = types.package;
            default = (stdenv.mkDerivation {
                name = "selkies-gstreamer-web";
                description = "The HTML5/JS web components for Selkies-Gstreamer.";
                src = fetchurl {
                    url = "https://github.com/selkies-project/selkies-gstreamer/releases/download/v${version}/selkies-gstreamer-web_v${version}.tar.gz";
                    sha256 = "sha256-9laKZvinvEi92VHNOjVgwCFQmfUm8QVuL3sUrbiq0QA=";
                };
                installPhase = ''
                    mkdir -p $out
                    tar -xzf $src -C $out/
                '';
           });
        };

        ethorbit.pkgs.python.selkies-gstreamer = mkOption {
            type = types.package;
            default = (python3Packages.buildPythonPackage {
                pname = "selkies-gstreamer";
                version = "${version}";
                format = "wheel";
                description = "Open-Source Low-Latency Linux WebRTC HTML5 Remote Desktop and 3D Graphics / Game Streaming Platform with GStreamer";
                src = fetchurl {
                    url = "https://github.com/selkies-project/selkies-gstreamer/releases/download/v${version}/selkies_gstreamer-${version}-py3-none-any.whl";
                    sha256 = "sha256-BI4GJoiZUZ/haMvClk8xscxSiJEDGAWtBiJE6bVDRBI=";
                };
                nativeBuildInputs = [
                    gobject-introspection
                ];
                buildInputs = [
                    config.ethorbit.pkgs.python.gputil
                    config.ethorbit.pkgs.python.basicauth
                    libnice.out
                    python311Packages.gst-python
                    python311Packages.pygobject3
                    python311Packages.watchdog
                    python311Packages.xlib
                    python311Packages.pynput
                    python311Packages.msgpack
                    python311Packages.pillow
                    python311Packages.websockets
                    python311Packages.psutil
                    python311Packages.prometheus-client
                    gst_all_1.gstreamer.out
                    gst_all_1.gst-libav
                    gst_all_1.gst-devtools
                    gst_all_1.gst-vaapi
                    gst_all_1.gst-plugins-base
                    gst_all_1.gst-plugins-bad
                    gst_all_1.gst-plugins-ugly
                    gst_all_1.gst-plugins-good
                    xorg.xrandr
                ];
                preFixup = ''
                    for f in $(find $out/bin/ -type f -executable); do
                        wrapProgram "$f" \
                          --prefix PATH ":" "${pkgs.xsel}/bin:${pkgs.xorg.xrandr}/bin/xrandr:$PATH" \
                          --prefix LD_LIBRARY_PATH ":" "${old.cudaPackages.cudatoolkit}/lib:$LD_LIBRARY_PATH" \
                          --prefix CUDA_PATH ":" "${old.cudaPackages.cudatoolkit}:$CUDA_PATH" \
                          --prefix SELKIES_WEB_ROOT ":" "${config.ethorbit.pkgs.python.selkies-gstreamer-web}/gst-web" \
                          --prefix GI_TYPELIB_PATH ":" "${gobject-introspection.out}/lib/girepository-1.0:$GI_TYPELIB_PATH" \
                          --prefix GST_PY_PATH ":" "${python311Packages.gst-python}/lib/python3.11" \
                          --prefix GST_PLUGIN_SYSTEM_PATH_1_0 ":" "${libnice.out}/lib/gstreamer-1.0:${gst_all_1.gstreamer.out}/lib/gstreamer-1.0:${gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${gst_all_1.gst-plugins-good}/lib/gstreamer-1.0:${gst_all_1.gst-plugins-bad}/lib/gstreamer-1.0:${gst_all_1.gst-plugins-ugly}/lib/gstreamer-1.0" \
                          --prefix PYTHONPATH ":" "${python311Packages.gst-python}/lib/python3.11/site-packages:$PYTHONPATH"
                    done
                '';
            });
        };
    };
}
