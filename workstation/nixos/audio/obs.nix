{ config, pkgs, ... }:

let
    obsScript = pkgs.writeShellScript "script.sh" ''
        # Allows us to make OBS record only certain apps' audio
        if ! ${pkgs.pulseaudio}/bin/pactl list short sinks | grep -q "^.*\\sOBS\\s"; then
            ${pkgs.pulseaudio}/bin/pactl load-module module-null-sink sink_name=OBS sink_properties=device.description=OBS
        fi

        # Make sure when a app's audio is routed through the OBS sink, we can still hear it through PulseEffects
        if ! ${pkgs.pulseaudio}/bin/pactl list modules short | grep "module-loopback" | grep -q OBS; then
            ${pkgs.pulseaudio}/bin/pactl load-module \
                module-loopback \
                source=OBS.monitor \
                sink=PulseEffects_apps \
                sink_dont_move=true \
                source_dont_move=true \
                sink_input_properties="media.name='OBSLoopback'" \
                source_output_properties="media.name='OBSLoopbackSource'" \
                latency_msec=1
        fi
    '';
in
{
    # Ensure the sink and loopback gets created when running OBS.
    ethorbit.components.recording.obs.extraCommands = ''
        ${obsScript.outPath}
    '';
}
