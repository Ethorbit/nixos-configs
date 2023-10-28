{ config, ... }:
{
	#age.identityPaths = [ "/root/.ssh/id_ed25519" ];
  	age.secrets."users/root/password" = { file = ../secrets/users.root.pass.age; };
	age.secrets."users/ethorbit/password" = { file = ../secrets/users.ethorbit.pass.age; };

	users.users = {	
		root = {
			passwordFile = config.age.secrets."users/root/password".path;
		};

		ethorbit = {
			isNormalUser = true;
			extraGroups = [ "wheel" "video" "audio" "podman" "libvirtd" "qemu-libvirtd" ];
			passwordFile = config.age.secrets."users/ethorbit/password".path;
		};
	};

}
