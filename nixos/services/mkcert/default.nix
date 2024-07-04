# Generates self-signed certificates in: /var/lib/mkcert/<entry name>/
# Files are named:
#   public
#   private
# Example: /var/lib/mkcert/mywebsite/public and /var/lib/mkcert/mywebsite/private

{ config, pkgs, lib, ... }:

with lib;

let
    # Rename entry keys to be systemd service names.
    entries = listToAttrs (map (v: { name = "mkcert@${v}"; value = config.ethorbit.services.mkcert."${v}" // { entryName = v; }; }) (attrNames config.ethorbit.services.mkcert));
in
{
    options.ethorbit.services.mkcert = mkOption {
        description = "Attribute set of the mkcert services, one for each domain.";
        example = literalExpression ''
            "localtesting" = {
                enable = true;
                owner = ${config.ethorbit.services.mkcert.owner.example};
                group = ${config.ethorbit.services.mkcert.group.example};
                domains = ${config.ethorbit.services.mkcert.domains.example};
            };
        '';
        type = (types.attrsOf (types.submodule {
            options = {
                owner = mkOption {
                    type = types.str;
                    description = "The user who can access the certificate files";
                    default = config.ethorbit.users.primary.username;
                    example = "root";
                };

                group = mkOption {
                    type = types.str;
                    description = "The group who can access the certificate files";
                    default = config.ethorbit.users.primary.username;
                    example = "websites";
                };

                domains = mkOption {
                    type = types.listOf types.str;
                    description = "The domains this certificate is for.";
                    default = [ ];
                    example = literalExpression ''
                        [
                            "localsite.internal"
                            "*.localsite.internal"
                        ]
                    '';
                };
            };
        }));
        default = {};
    };

    config = {
        systemd.tmpfiles.rules = [
            "d /var/lib/mkcert 0777 root root"
        ];

        system.activationScripts = (mapAttrs (name: data: {
            text = let
                dir = "/var/lib/mkcert/${data.entryName}";
                public = "${dir}/public";
                private = "${dir}/private";
            in ''
                if [ ! -f ${public} ] && [ ! -f ${private} ]; then
                    export CAROOT="/etc/ssl/certs"
                    ${pkgs.mkcert}/bin/mkcert -install
                    ${pkgs.mkcert}/bin/mkcert -cert-file ${public} -key-file ${private} ${escapeShellArgs data.domains}
                fi

                chown "${data.owner}":"${data.group}" ${public} ${private}
                chmod 650 ${public} ${private}

                # Health check.
                [ -f ${public} ] && [ -s ${public} ] &&\
                    [ -f ${private} ] && [ -s ${private} ] &&\
                    ${pkgs.openssl}/bin/openssl x509 -noout -pubkey -in ${public} > /dev/null &&\
                    ${pkgs.openssl}/bin/openssl pkey -pubout -noout -in ${private} > /dev/null ||\
                    exit 1
            '';
        }) entries);
    };
}
