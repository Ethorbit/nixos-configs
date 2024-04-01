{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		sunshine
	];
}