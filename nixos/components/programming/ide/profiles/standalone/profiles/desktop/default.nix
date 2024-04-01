{ config, ... }:

{
	imports = [
		../../.
		./packages.nix
		./home-manager.nix
		../../../../display-server/profiles/xserver
        ../../../../display-manager/profiles/lightdm
        ../../../../audio-server/profiles/pipewire
        ../../../../window-manager/profiles/i3
	];
}