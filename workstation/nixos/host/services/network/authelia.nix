{ config, lib, pkgs, ... }:

with lib;
let
    # Add authelia- before the instance names:
    instances = listToAttrs (map (v: { name = "authelia-${v}"; value = config.services.authelia.instances."${v}"; }) (attrNames config.services.authelia.instances));

    defaults.settings = {
        theme = mkDefault "dark";
        ntp = {
            address = mkDefault "time.google.com:123";
        };
    };
in
{
    services.authelia.instances = {
        "system" = defaults // {
            enable = true;
            secrets = {
                jwtSecretFile = "/var/lib/authelia-system/jwt_secret";
                storageEncryptionKeyFile = "/var/lib/authelia-system/storage_encryption_file";
                sessionSecretFile = "/var/lib/authelia-system/session_secret_file";
            };
            settings = {
                server = {
                    port = 9091;
                    host = "127.0.0.1";
                };
                default_redirection_url = "https://auth.${config.networking.hostName}.internal";
                access_control = {
                    default_policy = "deny";
                    rules = [
                        {
                            domain = [
                                "${config.networking.hostName}.internal"
                                "*.${config.networking.hostName}.internal" 
                            ];
                            policy = "two_factor";
                        }
                    ];
                };
                session = {
                    name = "authelia_session";
                    domain = "${config.networking.hostName}.internal";
                    same_site = "lax";
                    inactivity = "1h";
                    expiration = "3h";
                };
                notifier = {
                    filesystem = {
                        filename = "/var/lib/authelia-system/notification.txt";
                    };
                };
                authentication_backend = {
                    file = {
                        path = "/var/lib/authelia-system/users_database.yml";
                    };
                };
                storage = {
                    local = {
                        path = "/var/lib/authelia-system/db.sqlite3";
                    };
                };
                default_2fa_method = "totp";
                totp = {
                    disable = false;
                    issuer = "${config.networking.hostName}.internal";
                    digits = 6;
                    period = 30;
                    skew = 1;
                    secret_size = 32;
                };
            };
        };
    };
    # Generate the secrets for all instances.
    # Courtesy of https://discourse.nixos.org/t/authelia-and-nginx-on-nixos/30601/4
    systemd.services = (mapAttrs (name: _: {
        preStart = ''
            [ -f /var/lib/${name}/jwt_secret ] || {
              "${pkgs.openssl}/bin/openssl" rand -base64 32 > /var/lib/${name}/jwt_secret
            }
            [ -f /var/lib/${name}/storage_encryption_file ] || {
              "${pkgs.openssl}/bin/openssl" rand -base64 32 > /var/lib/${name}/storage_encryption_file
            }
            [ -f /var/lib/${name}/session_secret_file ] || {
              "${pkgs.openssl}/bin/openssl" rand -base64 32 > /var/lib/${name}/session_secret_file
            }
        '';
    }) instances);
}
