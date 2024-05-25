{ config, pkgs, lib, ... }:

with pkgs;
with lib;
{
    imports = [
        ../gputil
        ../basicauth
    ];

    options = {
        ethorbit.pkgs.python.selkies-gstreamer = mkOption {
            type = types.package;
            default = (python3Packages.buildPythonPackage {
                pname = "selkies-gstreamer";
                version = "1.5.2";
                format = "wheel";
                description = "Open-Source Low-Latency Linux WebRTC HTML5 Remote Desktop and 3D Graphics / Game Streaming Platform with GStreamer";
                src = fetchurl {
                    url = "https://github.com/selkies-project/selkies-gstreamer/releases/download/v1.5.2/selkies_gstreamer-1.5.2-py3-none-any.whl";
                    sha256 = "sha256-OO3b9pjljZO2t5ITuXnK4yPSnJghQlN+OouM0BQ9a8U=";
                };
                nativeBuildInputs = [
                    gobject-introspection
                ];
                buildInputs = [
                    config.ethorbit.pkgs.python.gputil
                    config.ethorbit.pkgs.python.basicauth
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
                    python311Packages.flask-basicauth
                    gst_all_1.gstreamer
                    gst_all_1.gst-libav
                    gst_all_1.gst-devtools
                    gst_all_1.gst-vaapi
                    gst_all_1.gst-plugins-base
                    gst_all_1.gst-plugins-bad
                    gst_all_1.gst-plugins-ugly
                    gst_all_1.gst-plugins-good
                ];
                # so that it stops crying with runtime errors [\/]
                preFixup = ''
                    wrapProgram $out/bin/selkies-gstreamer \
                      --prefix GI_TYPELIB_PATH ":" "${gobject-introspection.out}/lib/girepository-1.0:$GI_TYPELIB_PATH" \
                      --prefix GST_PY_PATH ":" "${python311Packages.gst-python}/lib/python3.11" \
                      --prefix PYTHONPATH ":" "${python311Packages.gst-python}/lib/python3.11/site-packages:$PYTHONPATH" \
                '';
                      #--prefix GSTREAMER_PATH ":" "${gst_all_1.gstreamer}:${gst_all_1.gst-devtools}:${gst_all_1.gst-plugins-base}:${gst_all_1.gst-plugins-bad}:${gst_all_1.gst-plugins-ugly}:${gst_all_1.gst-plugins-good}:${gst_all_1.gst-vaapi}:${gst_all_1.gst-libav}" \
                      #--prefix PATH ":" "${gst_all_1.gstreamer}/bin:${gst_all_1.gst-devtools}/bin:${gst_all_1.gst-plugins-base}/bin:${gst_all_1.gst-plugins-bad}/bin:${gst_all_1.gst-plugins-ugly}/bin:${gst_all_1.gst-plugins-good}/bin:${gst_all_1.gst-libav}/bin:$PATH" \
                      #--prefix LD_LIBRARY_PATH ":" "${python311Packages.pygobject3}/lib:${python311Packages.gst-python}/lib:${gst_all_1.gst-plugins-base}/lib:${gst_all_1.gst-devtools}/lib:${gst_all_1.gst-plugins-bad}/lib:${gst_all_1.gst-plugins-ugly}/lib:${gst_all_1.gst-plugins-good}/lib:${gst_all_1.gst-vaapi}/lib:${gst_all_1.gst-libav}/lib:$LD_LIBRARY_PATH" \
            });
        };
    };
}
