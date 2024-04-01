{ config, ... }:
{
    #age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    age.secrets."users/root/password" = { file = ./secrets/users/root/pass.age; };
    age.secrets."users/ethorbit/password" = { file = ./secrets/users/ethorbit/pass.age; };

    ethorbit.users.primary.username = "ethorbit";
    
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
