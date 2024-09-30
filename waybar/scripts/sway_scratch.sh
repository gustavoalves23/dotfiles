#!/bin/bash

# Get the list of applications on the scratchpad
scratchpad_items=$(swaymsg -t get_tree | jq -r '.nodes[] | select(.name == "__i3") | .nodes[] | select(.name == "__i3_scratch") | .floating_nodes[] | .name')

# Convert the list to an array
readarray -t items_array <<< "$scratchpad_items"

# Count the number of items
count=${#items_array[@]}

# Initialize the tooltip
tooltip=""

# Loop through the items and build the tooltip
for i in "${!items_array[@]}"; do
  tooltip+="${items_array[i]}"
  # Add a carriage return for all items except the last one
  if [ $i -lt $((count - 1)) ]; then
    tooltip+="\r"
  fi
done

# Create the JSON-like output
json_output="{\"text\": \"$count\", \"tooltip\": \"$tooltip\"}"

# Output the result
echo "$json_output"
