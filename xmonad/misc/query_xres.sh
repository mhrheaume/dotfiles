# Script to query current X screen resolution.
#
###

pix=$(xrandr -q | sed -n 's/.*current[ ]\([0-9]*\) x \([0-9]*\),.*/\1x\2/p')

case $1 in
"x")
  val=$(echo $pix | awk -F x '{ print $1 }')
  ;;
"y")
  val=$(echo $pix | awk -F x '{ print $2 }')
  ;;
*)
  echo "Invalid operation."
  exit 1
  ;;
esac

echo $val
