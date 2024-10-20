{ config, pkgs, lib, ... }:

with lib;
with pkgs;

let
    src = (fetchFromGitHub {
        owner = "pfanne";
        repo = "mousejail";
        rev = "b2f84d5002a6925aaa1261aaf36470534dd3d5e3";
        hash = "sha256-zZPILPphKB9e+IJSvPrfPkbwN4PFS8zTvXi/bfBWzqM=";
    });

    xbarrier = (stdenv.mkDerivation {
        inherit src;
        name = "xbarrier";
        buildInputs = [
            libgcc
            pkg-config
            xorg.libX11
            xorg.libXtst
            xorg.libXfixes
        ];
        buildPhase = ''
            gcc xbarrier.c $(pkg-config --cflags --libs x11 xfixes) -o xbarrier
        '';
        installPhase = ''
            mkdir -p "$out/bin"
            cp xbarrier "$out/bin/xbarrier"
            chmod +x "$out/bin/xbarrier"
        '';
    });
in
{
    options = {
        ethorbit.pkgs.mousejail = mkOption {
            type = types.package;
            # I cannot use the repo's unmodified script because it's too incompatible with nixos pathing
            default = (writeShellScriptBin "mousejail" ''
            SCRIPT_PATH=$(dirname $0)

            #check if toggle mode is activated and kill the other instance of mousejail if it exists
            if [ "$#" -gt 0 ]; then
                if [ "$1" -eq 1 ]; then
                    MOUSEJAIL_COUNT=$(pgrep -f '.*mousejail' | wc -w)
                    if [ "$MOUSEJAIL_COUNT" -gt 2 ]; then
                        for pid in $(pgrep -f '.*mousejail'); do
                            kill "$pid"
                        done

                        exit 0
                    fi
                fi
            fi

            #check if a windowid has been specified otherwise use the currently focused window
            if [ "$#" -gt 1 ]; then
                WINDOW_ID=$2
            else
                WINDOW_ID=$(${xdotool}/bin/xdotool getwindowfocus)
            fi

            create_barriers()
            {
                #get info of the window
                WINDOW_INFO=$(${xdotool}/bin/xdotool getwindowgeometry $WINDOW_ID)
                if [ "$?" -ne 0 ]; then
                    terminate
                fi
                #extract window information
                WINDOW_X_NEW=$(echo $WINDOW_INFO | awk -F'[ ,x]' '{print $4;}')
                WINDOW_Y_NEW=$(echo $WINDOW_INFO | awk -F'[ ,x]' '{print $5;}')
                WINDOW_WIDTH_NEW=$(echo $WINDOW_INFO | awk -F'[ ,x]' '{print $9;}')
                WINDOW_HEIGHT_NEW=$(echo $WINDOW_INFO | awk -F'[ ,x]' '{print $10;}')

                #check if barriers have not been created or need to be updated
                if [ "$(ps -p $BARRIER_LEFT -o comm=)" != "xbarrier" ] || [ "$WINDOW_X" != "$WINDOW_X_NEW" ] || [ "$WINDOW_Y" != "$WINDOW_Y_NEW" ] || [ "$WINDOW_WIDTH" != "$WINDOW_WIDTH_NEW" ] || [ "$WINDOW_HEIGHT" != "$WINDOW_HEIGHT_NEW" ]; then
                    #destroy previous barriers
                    destroy_barriers

                    WINDOW_X=$WINDOW_X_NEW
                    WINDOW_Y=$WINDOW_Y_NEW
                    WINDOW_WIDTH=$WINDOW_WIDTH_NEW
                    WINDOW_HEIGHT=$WINDOW_HEIGHT_NEW

                    #barrier overlap
                    BO=2
                    #create left barrier
                    ${xbarrier}/bin/xbarrier $WINDOW_X $(expr $WINDOW_Y - $BO) $WINDOW_X $(expr $WINDOW_Y + $WINDOW_HEIGHT + $BO) 1 & 
                    BARRIER_LEFT=$!
                    #create right barrier
                    ${xbarrier}/bin/xbarrier $(expr $WINDOW_X + $WINDOW_WIDTH) $(expr $WINDOW_Y - $BO) $(expr $WINDOW_X + $WINDOW_WIDTH) $(expr $WINDOW_Y + $WINDOW_HEIGHT + $BO) 4 & 
                    BARRIER_RIGHT=$!
                    #create upper barrier
                    ${xbarrier}/bin/xbarrier $(expr $WINDOW_X - $BO) $WINDOW_Y $(expr $WINDOW_X + $WINDOW_WIDTH + $BO) $WINDOW_Y 2 & 
                    BARRIER_UP=$!
                    #create lower barrier
                    ${xbarrier}/bin/xbarrier $(expr $WINDOW_X - $BO) $(expr $WINDOW_Y + $WINDOW_HEIGHT) $(expr $WINDOW_X + $WINDOW_WIDTH + $BO) $(expr $WINDOW_Y + $WINDOW_HEIGHT) 8 & 
                    BARRIER_DOWN=$!
                fi
            }

            destroy_barriers(){
                kill $BARRIER_LEFT > /dev/null 2>&1
                kill $BARRIER_RIGHT > /dev/null 2>&1
                kill $BARRIER_UP > /dev/null 2>&1
                kill $BARRIER_DOWN > /dev/null 2>&1
            }

            terminate()
            {
                destroy_barriers
                exit 0
            }

            #create trap to properly destroy all barriers when the script is terminated
            trap 'terminate' INT TERM

            #initialize the values so the ps command works properly
            BARRIER_LEFT=1
            BARRIER_RIGHT=1
            BARRIER_UP=1
            BARRIER_DOWN=1

            while true
            do
                #check if window is currently focused
                if [ "$WINDOW_ID" -eq "$(${xdotool}/bin/xdotool getwindowfocus)" ]; then
                    create_barriers
                else
                    destroy_barriers
                fi
                sleep 0.1
            done
            '');
        };
    };
}
