{ config, ... }:

{
	imports = [
		./hardware-configuration.nix
		./users.nix
		./services.nix
		./firewall.nix
		./containers
	];
	
	networking.hostName = "workstation";
	sudo.wheelNeedsPassword = false;
}