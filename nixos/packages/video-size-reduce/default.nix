{ config, lib, pkgs, ... }:

{
    options = with lib; with pkgs; {
        ethorbit.pkgs.video-size-reduce = mkOption {
            type = types.package;
            default = pkgs.writeShellScriptBin "video-size-reduce.sh" ''
            #!/usr/bin/env bash
            # For now this will just reduce & scale the pixels of a video because it's very effective
            # at dropping the file size. This will definitely reduce the quality of videos so beware..
            USER_SOURCE=$1
            USER_DEST=$2
            FIND_SOURCE=$3

            if [[ -z $FIND_SOURCE ]]; then 
                 find "$USER_SOURCE/" -type f -exec "$0" "$USER_SOURCE" "$USER_DEST" "{}" \;
            else 
                 filename=$(basename "$FIND_SOURCE")
                 DEST=$USER_DEST$(echo "$FIND_SOURCE" | sed -E 's,('"$USER_SOURCE"')[/\\]+,,g') 
                 folders=$(echo "$DEST" | sed 's,'"$filename"',,g') 
                 mkdir -p "$folders"
                 
                 # this happens for some reason despite regex removal above, just a temporary workaround...
                 if [[ -d "$DEST" ]]; then
                    rm -d "$DEST"
                    echo "Tried to create video file as directory, removing directory.. This bug needs to be addressed soon!"
                 fi

                 if [[ ! -f "$DEST" ]]; then 
                    echo "$DEST"
                    ffmpeg -y -i "$FIND_SOURCE" -vf "scale=trunc(iw/6)*2:trunc(ih/6)*2" -c:v libx265 -crf 28 "$DEST"   
                 else
                    echo "Skipping $DEST because it already exists!"
                 fi
            fi
            '';
        };
    };
}
