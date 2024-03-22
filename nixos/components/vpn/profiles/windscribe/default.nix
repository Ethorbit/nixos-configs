{ config, pkgs, ... }:

{
    options = {
        ethorbit.components.vpn.windscribe = {};
    };

    config = {
        environment.systemPackages = with pkgs; [
            wireguard-tools
        ];

        age.secrets."networking/vpn/windscribe/private.key" = {
            file = ./secrets/private.key.age;
        };
        
        age.secrets."networking/vpn/windscribe/preshared.key" = {
            file = ./secrets/preshared.key.age;
        };

        networking.wg-quick.interfaces = {
            Windscribe = {
                autostart = true;
                address = [ "100.126.161.7/32" ];
                dns = [ "10.255.255.1" ];
                privateKeyFile = config.age.secrets."networking/vpn/windscribe/private.key".path;
                peers = [
                    {
                        endpoint = "dfw-414-wg.whiskergalaxy.com:443";
                        publicKey = "gSj19b2N8kfxHE9SuU2IS+FGZaOlL5p5b3xth9adhHE=";
                        allowedIPs = [ "0.0.0.0/0" ];
                        presharedKeyFile = config.age.secrets."networking/vpn/windscribe/preshared.key".path;
                    }
                    {
                        endpoint = "sea-290-wg.whiskergalaxy.com:443";
                        publicKey = "89DUtbYYyXcAktaB2cnCVA/YiZQEddYHuOz2K0vBAn4=";
                        allowedIPs = [ "0.0.0.0/0" ];
                        presharedKeyFile = config.age.secrets."networking/vpn/windscribe/preshared.key".path;
                    }
                    {
                        endpoint = "lax-321-wg.whiskergalaxy.com:443";
                        publicKey = "EOprktmhNg2NV9HqyHTs+uLNnTwpVnXe1/wBIFesQTE=";
                        allowedIPs = [ "0.0.0.0/0" ];
                        presharedKeyFile = config.age.secrets."networking/vpn/windscribe/preshared.key".path;
                    }
                    {
                        endpoint = "jfk-106-wg.whiskergalaxy.com:443";
                        publicKey = "Tu8tlHPMbkXRANX3AF1Te+stynfOJS1mCtIOjiRToCg=";
                        allowedIPs = [ "0.0.0.0/0" ];
                        presharedKeyFile = config.age.secrets."networking/vpn/windscribe/preshared.key".path;
                    }
                    {
                        endpoint = "mia-140-wg.whiskergalaxy.com:443";
                        publicKey = "1S9LgDyVSo2X34ZG8ukQQ7vqL5RpmXszNe0SYNjiUws=";
                        allowedIPs = [ "0.0.0.0/0" ];
                        presharedKeyFile = config.age.secrets."networking/vpn/windscribe/preshared.key".path;
                    }
                ];
            };
        };
    };
}
