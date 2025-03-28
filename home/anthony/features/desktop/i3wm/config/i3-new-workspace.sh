#!/bin/sh
SCRIPTNAME=$(basename $0)
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# when we re-enter this script this env var will
# be set.
if [[ -n $SR ]]; then
    echo ""
    echo " New workspace: "
    echo ""
    echo -n " > "
    read newname
    i3-msg workspace $newname
fi

# launch alacritty instance with the size we want
# and re-enter this script.
SR=true zsh -c "alacritty \
    -o window.dimensions.columns=50 \
    -o window.dimensions.lines=3 \
    -o font.size=16.0 \
    -o window.padding.x=20 \
    -o window.padding.y=20 \
    --title \"New Workspace\" \
    -e $SCRIPTPATH/$SCRIPTNAME"&
