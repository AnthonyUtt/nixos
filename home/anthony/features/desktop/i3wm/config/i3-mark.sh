#!/bin/sh
SCRIPTNAME=$(basename $0)
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
# when we re-enter this script this env var will
# be set.
if [[ -n $SM ]]; then
    echo ""
    echo " Set mark to?"
    echo ""
    echo -n " > "
    read mark
    i3-msg focus tiling
    i3-msg mark $mark
    exit
fi

# launch alacritty instance with the size we want
# and re-enter this script.
SM=true zsh -c "alacritty \
    -o window.dimensions.columns=25 \
    -o window.dimensions.lines=3 \
    -o font.size=16.0 \
    -o window.padding.x=20 \
    -o window.padding.y=20 \
    --title \"Set Window Mark\" \
    -e $SCRIPTPATH/$SCRIPTNAME"&
