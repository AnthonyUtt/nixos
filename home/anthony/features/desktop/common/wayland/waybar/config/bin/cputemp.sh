#! /usr/bin/env nix-shell
#! nix-shell -i bash -p lm_sensors

check() {
  command -v "$1" 1>/dev/null
}

check sensors || exit

data="$(sensors coretemp-isa-0000 | sed 's/+//g')"
package="$(echo "$data" | awk -e '/Package/ {print $4}')"
coretemp="$(echo "$data" | awk -e '/Core/ {print $3}')"

tooltip="<b>Core Temp: $package </b>\n"

# "format-icons" : [ "", "", "", "", "" ] ,
tempint=${package%.*}
temp="<b>${tempint}󰔄</b>"
icon=""
class="cool"
[ "$tempint" -gt 50 ] && {
  icon=""
  class="normal"
}
[ "$tempint" -gt 70 ] && {
  icon=" "
  class="warm"
}
[ "$tempint" -gt 85 ] && {
  icon=" "
  class="warn"
}
[ "$tempint" -gt 95 ] && {
  icon=" "
  class="critical"
}

j=0
for i in $coretemp; do
  tooltip+="Core $j: $i\n"
  ((j = j + 1))
done
tooltip="${tooltip::-2}"
cat <<EOF
{"text":"$temp","tooltip":"$tooltip", "class": "$class"}
EOF
