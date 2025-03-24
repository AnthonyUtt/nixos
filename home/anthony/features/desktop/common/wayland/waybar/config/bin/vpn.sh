#! /usr/bin/env nix-shell
#! nix-shell -i bash -p jq curl

check() {
  command -v "$1" >/dev/null 2>&1
}

check jq || {
  cat <<EOF
  { "class": "disconnected", "text": "NaN", "tooltip": "jq is not installed" }
EOF
  exit
}

token=""
[ -f "$HOME/.config/ipinfo.token" ] && token="$(cat "$HOME"/.config/ipinfo.token)"

test -d /proc/sys/net/ipv4/conf/tun0 && {
  # gip_data=$(check curl && curl -s http://ipecho.net/plain)
  gip_data=$(check curl && curl -su "$token": http://ipinfo.io)
  tooltip=$(echo "$gip_data" | jq -r '"IP: " + .ip + "\\n" + .city + ", " + .region + ", " + .country')
  cat <<EOF
  { "class": "connected", "text": "<span><small> 󰩠</small></span>", "tooltip": "<b>Vpn is connected</b>\n$tooltip" }
EOF
}

