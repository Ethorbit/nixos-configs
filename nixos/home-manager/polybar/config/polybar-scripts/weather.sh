#!/bin/bash
if [[ $(host "geocoding-api.open-meteo.com" | grep -E "not found|connection refused") ]]; then 
    echo ""; 
else
    set_weather()
    {
        weather=$(weather-Cli get "Gresham" 2> /dev/null) || echo ""
    }
    
    set_weather

    temp=$(echo "$weather" | grep "Temperature")
    wind=$(echo "$weather" | grep "Wind Speed")

    if [[ "$temp" ]]; then 
        temp_celsius=$(echo "$temp" | awk '{ print $2 }' | grep -o "\-\?[0-9]\+" | head -1)
        temp_farenheit=$(echo "($temp_celsius * 1.8) + 32" | bc)
        echo_temp="⛅  $temp_farenheit °F" #🌡️ 
    else
        echo_temp=""
    fi 

    if [[ "$wind" ]]; then  
        wind_kmph=$(echo "$wind" | awk '{ print $3 }') #| grep -o "[0-9]\+" | head -1)
        wind_mph=$(echo "$wind_kmph * 0.6" | bc)
        echo_wind=" 〰️ $wind_mph mph" #💨
    else
        echo_wind=""
    fi 

    echo "$echo_temp $echo_wind"
fi
