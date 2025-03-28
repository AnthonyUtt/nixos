#!/bin/sh

CURRENT_WORKSPACE_ID=`i3-msg -t get_workspaces | jq -r '.[] | select(.focused == true) | .id'`

# "Primary" container is the largest one by width
PRIMARY_CONTAINER_ID="$(i3-msg -t get_tree | jq -r --argjson wsid $CURRENT_WORKSPACE_ID 'recurse(.nodes[]) | select(.id == $wsid) | .nodes | max_by(.rect.width) | .id')"

i3-msg swap container with con_id $PRIMARY_CONTAINER_ID
