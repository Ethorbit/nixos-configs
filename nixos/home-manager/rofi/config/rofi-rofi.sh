#!/usr/bin/env bash
# Yes. A rofi menu for rofi menus. 
# Currently menus need to be manually added as there's no apparent way to have rofi list menus.... 
theme="$HOME/.config/rofi/launchers_custom/ribbon/ribbon_left_ethorbit" 

# Key is display name, value is the rofi menu name. 
declare -A menus=(
    [A:Programs]=drun
    [B:Emojis]=emoji
)

menu_strings=
for menu_key in ${!menus[@]}; do 
    echo "Key $menu_key"
    [[ -z "$menus_string" ]] && menus_string="$menu_key" || menus_string="$menus_string\n$menu_key" 
done 

menu=${menus[$(echo -e "$menus_string" | rofi -dmenu -theme "$theme")]}
[[ ! -z "$menu" ]] && rofi -mode -show "$menu" -theme "$theme" 2>&1 &
