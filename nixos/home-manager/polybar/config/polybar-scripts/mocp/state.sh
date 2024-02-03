STATE=$(mocp -i | awk 'NR==1' | cut -d ':' -f 2 | tr -d ' ')
echo "$STATE"
