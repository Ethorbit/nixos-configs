{ config, lib, pkgs, ... }:

with lib;
let
    # Add authelia- before the instance names:
    instances = listToAttrs (map (v: { name = "authelia-${v}"; value = config.services.authelia.instances."${v}"; }) (attrNames config.services.authelia.instances));
in
{
    services.authelia.instances = {
        "personal" = {
            enable = true;
            secrets = {
                jwtSecretFile = "/var/lib/authelia-personal/jwt_secret";
                storageEncryptionKeyFile = "/var/lib/authelia-personal/storage_encryption_file";
                sessionSecretFile = "/var/lib/authelia-personal/session_secret_file";
            };
            settings = {
                theme = "dark";
                server = {
                    port = 9091;
                    host = "localhost";
                };
                access_control = {
                    default_policy = "two_factor";
                };
                session = {
                    expiration = "3h";
                    inactivity = "1h";
                    domain = "workstation.internal";
                };
                notifier = {
                    filesystem = {
                        filename = "/var/lib/authelia-personal/notification.txt";
                    };
                };
                authentication_backend = {
                    file = {
                        path = "/var/lib/authelia-personal/users_database.yml";
                    };
                };
                storage = {
                    local = {
                        path = "/var/lib/authelia-personal/db.sqlite3";
                    };
                };
                default_redirection_url = "http://host/auth";
                default_2fa_method = "totp";
                totp = {
                    issuer = "host";
                    period = 30;
                    skew = 1;
                };
            };
        };
    };

    # Generate the secrets for all instances.
    # Courtesy of https://discourse.nixos.org/t/authelia-and-nginx-on-nixos/30601/4
    systemd.services = (mapAttrs (name: _: {
        preStart = ''
            [ -f /var/lib/authelia-personal/jwt_secret ] || {
              "${pkgs.openssl}/bin/openssl" rand -base64 32 > /var/lib/${name}/jwt_secret
            }
            [ -f /var/lib/authelia-personal/storage_encryption_file ] || {
              "${pkgs.openssl}/bin/openssl" rand -base64 32 > /var/lib/${name}/storage_encryption_file
            }
            [ -f /var/lib/authelia-personal/session_secret_file ] || {
              "${pkgs.openssl}/bin/openssl" rand -base64 32 > /var/lib/${name}/session_secret_file
            }
        '';
    }) instances);
}
