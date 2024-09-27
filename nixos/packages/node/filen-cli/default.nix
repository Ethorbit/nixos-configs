{ config, lib, pkgs, ... }:

with pkgs;
with lib;

let
    version = "0.0.12";

    files = (buildNpmPackage {
        pname = "filen-cli";
        version = "${version}";
        src = (fetchFromGitHub {
            owner = "FilenCloudDienste";
            repo = "filen-cli";
            rev = "v${version}";
            hash = "sha256-jLSkpyPbIAdZsPc2UBnKSvgazVeHWItWescF4g9c7Nw=";
        });

        # build script wants a key file we don't have, 
        # so we're going to disable auto build and do it manually
        dontNpmBuild = true;
        npmPackFlags = [ "--ignore-scripts" ];
        npmDepsHash = "sha256-T69yC2T3yu1LLwg2ph9Y+eKeepS1jUJKhgU5E3XgL3A=";

        installPhase = ''
            # We don't need to save credentials inside a package.
            echo "unset" > key

            npm run build

            mkdir -p $out
            cp -rap ./* $out/
        '';
    });
in
{
    options.ethorbit.pkgs.node.filen-cli = mkOption {
        type = types.package;
        default = pkgs.writeShellScriptBin "filen" ''
            # this is because filen-network-drive uses dpkg to check if fuse3 is installed.. :P
            # it uses dpkg -l | grep -E "^ii\\s+fuse3\\s|^ii\\s+libfuse3\\s" to do so
            # so we're basically tricking it.
            dpkg() {
                echo "ii fuse3 ii libfuse3"
            }
            export -f dpkg

            ${pkgs.nodejs_22}/bin/node "${files}/build/index.js" "$@"
        '';
    };
}
