#!/bin/bash

file="/etc/nginx/stream-proxy.conf"
backend="backend"

# Find the biggest backend number in the file
biggest_number=$(grep -oP '(?<=backend)\d+' "$file" | sort -nr | head -n 1)

if [[ -n "$biggest_number" ]]; then
    # Increment the number
    next_number=$((biggest_number + 1))

    # Delete the last line of the file
    sed -i '$ s/}$//' "$file"

    # Write the updated line to the file followed by }
    echo "$backend$next_number" >> "$file"
    echo "}" >> "$file"
    echo "Added backend$next_number to the file and closed the block."
else
    echo "No backend found in the file. Adding backend1."
    echo "$backend1" >> "$file"
    echo "}" >> "$file"
fi
