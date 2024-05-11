{ config, pkgs, lib, ... }:

{
    options = {
        ethorbit.pkgs.rofi-adi1090x = with pkgs; with lib; mkOption {
            type = types.package;
            default = (stdenv.mkDerivation {
                name = "rofi-adi1090x";
                src = (fetchFromGitHub {
                    owner = "adi1090x";
                    repo = "rofi";
                    rev = "7e236dd67fd98304e1be9e9adc2bed9106cf895b";
                    hash = "sha256-K6WQ+olSy6Rorof/EGi9hP2WQpRONjuGREby+aBlzYg=";
                });
                installPhase = ''
                    export HOME="$out"
                    export FONT_DIR="$HOME/.local/share/fonts"
                    export ROFI_DIR="$HOME/.config/rofi"
                    mkdir -p "$FONT_DIR"
                    mkdir -p "$ROFI_DIR"
                    cat "$src/setup.sh" | sh
                    #find "$out/"
                    #exit 1
                '';
                buildInputs = [ pkgs.fontconfig ];
           });
        };
    };

    config = { 
        environment.systemPackages = [ config.ethorbit.pkgs.rofi-adi1090x ];
    };
}
