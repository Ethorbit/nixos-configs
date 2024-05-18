{ config, pkgs, lib, ... }:

{
    options.ethorbit.pkgs.ctrld = with pkgs; with lib; mkOption {
        type = types.package;
        default = (buildGoModule {
            pname = "ctrld";
            version = "1.3.6";
            # Check seems to just time out every time?
            doCheck = false;
            src = (fetchFromGitHub {
                owner = "Control-D-Inc";
                repo = "ctrld";
                rev = "429a98b6900242743a82d417461c64162edc00d1";
                hash = "sha256-ybhofOfTax1lyV0JHU9menwEAXFmE288ZlBgKJuEnWI=";
            });
            vendorHash = "sha256-UN0gOFxMS0iWvg6Iv+aeYoduffJ9Zanz1htRh3ANjkY=";
        });
    };
}
