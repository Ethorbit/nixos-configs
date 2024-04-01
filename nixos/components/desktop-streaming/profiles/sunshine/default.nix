{ config, ... }:

{
	imports = [
		./firewall-rules.nix
		./packages.nix
	];
}