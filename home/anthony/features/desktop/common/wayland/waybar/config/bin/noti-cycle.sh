#! /usr/bin/env nix-shell
#! nix-shell -i bash -p mako rofi
# Toggles the dnd state in mako notification.

check() {
  command -v "$1" 1>/dev/null
}

notify() {
  check notify-send && {
    notify-send -a "Mako" "$@"
    return
  }
  echo "$@"
}

swaync=false
mako=false

pgrep -x swaync &>/dev/null && swaync=true
pgrep -x mako &>/dev/null && mako=true
if $mako && ! $swaync; then
  tooltip="<b>Daemon -> Mako</b>\nOn Click Cycle Dnd's"
  state="$(makoctl mode | sed -z 's/\n/ /g')"

  toggle() {
    case "$state" in
    "default silent ") notify "DND Enabled" && makoctl mode -a "do-not-disturb" ;;
    *"disturb"*) makoctl mode -r "silent" -r "do-not-disturb" && notify "DND Disabled" ;;
    *) makoctl mode -a "silent" && notify "Silent Mode" ;;
    esac
  }

  if [ $# -eq 1 ]; then
    if [[ "$1" = *"rofi"* ]]; then
      case "$state" in
      "default silent ") str=" Silent\nDND\nNotification" ;;
      *"disturb"*) str="Silent\n DND\nNotification" ;;
      *) str="Silent\nDND\n Notification" ;;
      esac

      choice=$(echo -e "$str" | rofi -dmenu -i -l 3 -config ~/.config/rofi/menu.d/notification.rasi)
      case $choice in
      Silent)
        makoctl mode -r "silent" -r "do-not-disturb"
        makoctl mode -a "silent" && notify "Silent Mode"
        pkill -SIGRTMIN+2 waybar
        ;;
      DND)
        makoctl mode -r "silent" -r "do-not-disturb"
        notify "DND Enabled" && makoctl mode -a "do-not-disturb"
        pkill -SIGRTMIN+2 waybar
        ;;
      Notification)
        makoctl mode -r "silent" -r "do-not-disturb"
        pkill -SIGRTMIN+2 waybar
        ;;
      *)
        notify "Battery Saver" "No option selected"
        ;;
      esac
    else
      case "$state" in
      "default silent ")
        cat <<EOF
{"text":"","tooltip":"$tooltip\n<b>State<\/b>: Silent"}
EOF
        ;;
      *"disturb"*)
        cat <<EOF
{"text":"","tooltip":"$tooltip\n<b>State<\/b>: DND"}
EOF
        ;;
      *)
        cat <<EOF
{"text":"󰂞","tooltip":"$tooltip\n<b>State:<\/b> Notification"}
EOF
        ;;
      esac
    fi
  else
    toggle &>/dev/null
    pkill -SIGRTMIN+2 waybar
  fi
fi

if $swaync && ! $mako; then
  toggle() {
    swaync-client -d
  }
  tooltip="<b>Daemon -> Swaync</b>"
  dnd=$(swaync-client -D)
  if [ $# -eq 1 ]; then
    if [[ "$1" = *"rofi"* ]]; then
      swaync-client -t -sw
    else
      case "$dnd" in

      "false")
        cat <<EOF
{"text":"","tooltip":"$tooltip\n<b>State<\/b>: Notify"}
EOF
        ;;
      "true")
        cat <<EOF
{"text":"","tooltip":"$tooltip\n<b>State<\/b>: Dnd"}
EOF
        ;;

      esac
    fi
  else
    toggle &>/dev/null
    pkill -SIGRTMIN+2 waybar
  fi
fi
