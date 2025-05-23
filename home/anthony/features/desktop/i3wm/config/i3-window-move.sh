#!/bin/sh
SCRIPTNAME=$(basename $0)
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
IFS=$'\n'

# check for env variable, if exists we are the
# forked shell, get the waiting string from the fifo
# and call fzf and sway from there.
prompt="Workspace> "
header="Move window to which workspace?"
if [[ -n $SWM_FIFO ]]; then
    str=$(cat $SWM_FIFO)
    # rm the fifo, we are done with it
    rm -rf $SWM_FIFO

    selection=$(printf $str | fzf --print-query --prompt="$prompt" $fzf_color)
    readarray -t query_and_workspace <<< "$selection"
    query="${query_and_workspace[0]}"
    workspace="${query_and_workspace[1]}"

    if [[ -n $workspace ]]; 
    then
        selection=$workspace
    elif [[ -n $query ]];
    then 
        if [[ ${query##*:} == "new" ]]; 
        then 
            selection=${query%:*}
        else 
            selection=$query
        fi
    else
        exit
    fi

    i3-msg focus tiling
    i3-msg move window to workspace $selection
    i3-msg workspace $selection
    notify-send -u low "moved window to workspace: $selection"
    exit
fi

# build the selection string we will ultimate
# pipe to fzf, take note of largest string to set
# columns and number of lines to set lines for alacritty.
columns=0
lines=0
str=""
workspaces=($(i3-msg -t get_workspaces | jq -r -c '.[] | .name'))
for workspace in "${workspaces[@]}"; do
    if [[ ${#workspace} -gt $columns ]];
    then
        columns=${#workspace}
    fi
    lines=$((lines+1))
    str="$str$workspace\n"
done

# add some padding to the terminal for 
# lines and columns, for columns make sure
# we take the prompt into the padding consideration
lines=$((lines+3))
columns=$((columns+"${#header}"+5))
if [[ columns -gt 100 ]];
then
    columns=100
fi

# create fifo and launch a terminal with the title "fzf-switcher"
# run the script in the new terminal which will see the env vars
# and execute the first if block in this script.
fifo=/tmp/sws-$(date +%s)
mkfifo $fifo
SWM_FIFO=$fifo zsh -c "alacritty \
    -o window.dimensions.columns=$columns \
    -o window.dimensions.lines=$lines \
    -o font.size=16.0 \
    -o window.padding.x=20 \
    -o window.padding.y=20 \
    --title \"Move Window to Workspace\" \
    -e $SCRIPTPATH/$SCRIPTNAME"&
echo -n $str > $fifo
