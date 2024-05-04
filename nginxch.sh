#!/bin/bash

file="/etc/nginx/stream-proxy.conf"
backend="backend"

# Find the biggest backend number in the file
biggest_number=$(grep -oP '(?<=backend)\d+' "$file" | sort -nr | head -n 1)

if [[ -n "$biggest_number" ]]; then
    # Increment the number
    next_number=$((biggest_number + 1))

    # Write the updated line to the file followed by }
    sed -i "\$i$backend$next_number" "$file"
    sed -i '$ a\'"$backend$next_number"'\
}' "$file"
    echo "Added backend$next_number to the file before the last '}'."
else
    sed -i "\$i$backend"1 "$file"
    sed -i '$ a\'"$backend"1'\
}' "$file"
    echo "No backend found in the file. Adding backend1."
fi
