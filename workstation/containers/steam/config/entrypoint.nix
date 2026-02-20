{ writeShellScriptBin }:

writeShellScriptBin "entrypoint.sh" ''
    obs --startreplaybuffer --minimize-to-tray --disable-shutdown-check &
    steam-acolyte
''
