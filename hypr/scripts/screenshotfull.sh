DIR="$HOME/Pictures/Screenshots/"
NAME="screenshot_$(date +%d%m%Y_%H%M%S).png"

grim $DIR/$NAME 
notify-send "Screenshot created!"
