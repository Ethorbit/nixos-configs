# Custom script I wrote. It aims to make repetitive download tasks as simple as possible
{ config, lib, pkgs, ... }:

{
    options = {
        ethorbit.pkgs.yt-dlp-wrapper = with pkgs; with lib; mkOption {
            type = types.package;
            default = pkgs.writeShellScriptBin "yt-dlp-wrapper.sh" ''
            #!/usr/bin/env bash
            
            maxnum="99999999"
            nothumbs=0

            while getopts ":c:d:a:n:" opt; do
                case "$opt" in
                    c) content=$OPTARG ;;
                    d) dest=$OPTARG ;;
                    a) audio=$OPTARG ;;
                    n) maxnum=$OPTARG ;;
                    --nothumbnails) nothumbs=1 ;;
                esac 
            done 
            shift $(( OPTIND - 1 ))

            if [ -z "$content" ]; then 
                echo "No content (-c) specified, there is nothing to download.."
            fi 

            if [ -z "$dest" ]; then 
                echo "Destination (-d) not provided, setting to current directory."
                dest=$PWD
            fi

            if [[ ! -z "$content" && ! -z "$dest" ]]; then
                echo "Downloading $content to $dest..."
                mkdir -p $dest 
                
                if [ $audio ]; then 
                    ${pkgs.yt-dlp}/bin/yt-dlp "$content" -o "$dest/%(title)s.%(ext)s" \
                        -x \
                        --restrict-filenames \
                        --audio-format best \
                        --audio-quality 0 \
                        --max-downloads $maxnum \
                        --no-mtime \
                        --verbose
                else 
                    ${pkgs.yt-dlp}/bin/yt-dlp "$content" -o "$dest/%(title)s/%(title)s.%(ext)s" \
                        `[[ nothumbs -le 0 ]] && echo "-o "thumbnail:$dest/%(title)s/thumbnails/"` \
                        -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" \
                        --restrict-filenames \
                        --merge-output-format mp4 \
                        --write-info-json \
                        --write-annotations \
                        --write-description \
                        --write-all-thumbnails \
                        --max-downloads $maxnum \
                        --verbose
                fi 
            fi 
            '';
        };
    };
}
