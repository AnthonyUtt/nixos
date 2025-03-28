#!/bin/sh
SCRIPTNAME=$(basename $0)
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
IFS=$'\n'

# check for env variable, if exists we are the
# forked shell, get the waiting string from the fifo
# and call fzf and sway from there.
prompt="Marks> "
header="Switch to which mark? (d) to delete"
if [[ -n $SMS_FIFO ]]; then
    # we are in the forked shell, read from
    # the provided FIFO and obtain the marks str
    # and pipe to fzf for selection.
    str=$(cat $SMS_FIFO)
    rm -rf $SMS_FIFO
    selection=$(printf $str | fzf  --header=$header --prompt="$prompt" $fzf_color --expect="d")

    readarray -t op_and_mark <<< "$selection"
    op="${op_and_mark[0]}"
    mark="${op_and_mark[1]}"

    if [[ -z $mark ]]; then
        exit
    fi

    if [[ $op == "d" ]]; then
        i3-msg unmark $mark
        notify-send -u low "deleted mark: $mark"
        exit
    fi

    i3-msg "[con_mark=\b$mark\b]" focus
    notify-send -u low "moved to marked window $mark"
    exit
fi

# build the selection string we will ultimate
# pipe to fzf, take note of largest string to set
# columns and number of lines to set lines for alacritty.
columns=1
lines=0
str=""
marks=($(i3-msg -t get_marks | jq -r '.[]'))
for mark in "${marks[@]}"; do
    if [[ ${#mark} -gt $columns ]];
    then
        columns=${#mark}
    fi
    lines=$((lines+1))
    str="$str$mark\n"
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
fifo=/tmp/sts-$(date +%s)
mkfifo $fifo
SMS_FIFO=$fifo zsh -c "alacritty \
    -o window.dimensions.columns=$columns \
    -o window.dimensions.lines=$lines \
    -o font.size=16.0 \
    -o window.padding.x=20 \
    -o window.padding.y=20 \
    --title \"Switch to Mark\" \
    -e $SCRIPTPATH/$SCRIPTNAME"&
echo -n $str > $fifo 
