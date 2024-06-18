{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # chromium and ungoogled-chromium crash in containers \o/
        # brave and google chrome work and I'm not picking google chrome...
        brave
    ];
}
