{ config, lib, ... }:

{
	options = with lib; {
		ethorbit.components.sunshine.sourceCIDR = mkOption {
			type = types.str;
			default = "192.168.0.0/16";
		};
	}

	config = lib.mkIf (config.networking.firewall.enable == true) {
		networking.firewall = {
			extraCommands = ''
				iptables -N SUNSHINE
				iptables -A SUNSHINE -p udp -m multiport --dports 47998,47999,48000,48002 -s ${config.ethorbit.components.sunshine.sourceCIDR} -j ACCEPT
				iptables -A SUNSHINE -p tcp -m multiport --dports 47984,47989,47990,48010 -s ${config.ethorbit.components.sunshine.sourceCIDR} -j ACCEPT
				iptables -A INPUT -j SUNSHINE
			'';
			
			extraStopCommands = ''
				iptables -D SUNSHINE
			'';
		};
	};
}