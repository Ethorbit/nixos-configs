#!/bin/bash
# Display currently playing song filename

cd $(dirname $0)
long=0
sleep_pid=0
scroll_text_pos=0

toggle() {
    long=$(((long + 1) % 2))
    
    if [ "$sleep_pid" -ne 0 ]; then
        kill $sleep_pid >/dev/null 2>&1
    fi
}

trap "toggle" USR1

scrolling_function() {
    local song="$1"
    local length="$2"
    local pos="$3"
    
    echo "🎵 ${song:$pos:$length}"
}

while :; do
    STATE=$(./state.sh)

    case $STATE in
        STOP)
        # just print nothing.
        ;;
        PAUSE)
        echo "🎵"
        ;;
        PLAY)
        song_name="$(mocp -i | awk 'NR==2' | sed 's:.*/::')"
        long_length=10
        
        if [ $long -eq 0 ] && [ ${#song_name} -gt $long_length ]; then
            # Make scrolling text, name is long and collapsed
            scroll_amount=3

            # Finished scrolling, start over
            if [ $((scroll_text_pos + long_length)) -ge ${#song_name} ]; then
                scroll_text_pos=0
            else
                scroll_text_pos=$((scroll_text_pos + scroll_amount))
            fi
            
            scrolling_song_name="${song_name:$scroll_text_pos:$long_length}"
            
            echo "🎵 $scrolling_song_name"
        else
            scroll_text_pos=0
            scrolling_song_name="$song_name"
            echo "🎵 $song_name"
        fi
        ;;
    esac
    
    sleep 1 &
    sleep_pid=$!
    wait
done

