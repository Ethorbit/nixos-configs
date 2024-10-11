# TODO: build from source using Dotnet tools
# I tried this earlier, but kept getting missing package errors
# It's an issue with their project, because it happens
# in Docker Ubuntu as well..

# For now, you can just use the dreaded AppImage.

{ config, lib, pkgs, ... }:

with lib;
with pkgs;

let
    version = "0.6.1";
    pname = "nexusmods";
    name = "NexusMods.App.x86_64.AppImage";
    description = ''Mod With Confidence. The future of modding with Nexus Mods.'';
    src = fetchurl {
        url = "https://github.com/Nexus-Mods/NexusMods.App/releases/download/v${version}/${name}";
        hash = "sha256-FiWs5CCByj/ddjaYzjypATPK4Yk9ql+rsKr3qmdHfJ0=";
    };
    appimageContents = appimageTools.extractType1 { inherit name src; };
    appimage = (appimageTools.wrapType1 {
        inherit name description src;
        version = "${version}";
        extraInstallCommands = ''
            mv $out/bin/${name} $out/bin/${pname}
          '';
    });
    appimageWrapper = (pkgs.writeShellScriptBin "${pname}" ''
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.icu}/lib
        exec ${appimage}/bin/${pname}
    '');
    desktop = (pkgs.makeDesktopItem {
        name = pname;
        desktopName = "Nexus Mods";
        exec = "${appimageWrapper}/bin/${pname} %f";
        terminal = true;
    });
in
{
    options = {
        ethorbit.pkgs.appimage.nexusmods = mkOption {
            type = types.package;
            default = (stdenv.mkDerivation {
                inherit name description;
                src = ./.;
                buildInputs = [
                    appimageWrapper
                    desktop
                ];
                phases = [ "installPhase" ];
                installPhase = ''
                    mkdir -p $out/bin
                    mkdir -p $out/share/applications
                    cp ${appimageWrapper}/bin/${pname} $out/bin/${pname}
                    cp ${desktop}/share/applications/${pname}.desktop $out/share/applications/${pname}.desktop
                '';
            });
        };
    };
}
