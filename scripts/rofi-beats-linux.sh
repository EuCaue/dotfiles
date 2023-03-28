#!/bin/sh

# add more args here according to preference
ARGS="--volume=53"

notification(){
# change the icon to whatever you want. Make sure your notification server 
# supports it and already configured.

# Now it will receive argument so the user can rename the radio title
# to whatever they want

	notify-send "Playing now: " "$@" --icon=media-tape
}

menu(){
	printf "1. Lofi Girl\n"
  printf "2. Lofi Hunter\n"
  printf "3. Lofi HipHop\n"
	printf "4. Chillhop\n"
	printf "5. Box Lofi\n"
	printf "6. The Bootleg Boy\n"
	printf "7. Radio Spinner\n"
	printf "8. SmoothChill\n"
  printf "9. Lofi TokyoGhoul\n"
  printf "10. Lofi TokyoGhoul Alt\n"
  printf "11. Lofi TokyoGhoul Playlist\n"
  printf "12. Cloudy Sakura"
}

main() {
	choice=$(menu | rofi -dmenu -p "Station"| cut -d. -f1)

	case $choice in
		1)
			notification "Lofi Girl ☕️🎶";
            URL="https://play.streamafrica.net/lofiradio"
			break
			;;
    2)
			notification "Lofi Hunter ☕️🎶";
            URL="https://live.hunter.fm/lofi_high"
			break
			;;
    3)
			notification "Lofi HipHop ☕️🎶";
            URL="http://hyades.shoutca.st:8043/stream"
			break
			;;
		4)
			notification "Chillhop ☕️🎶";
            URL="http://stream.zeno.fm/fyn8eh3h5f8uv"
			break
			;;
		5)
			notification "Box Lofi ☕️🎶";
            URL="http://stream.zeno.fm/f3wvbbqmdg8uv"
			break
			;;
		6)
			notification "The Bootleg Boy ☕️🎶";
            URL="http://stream.zeno.fm/0r0xa792kwzuv"
			break
			;;
		7)
			notification "Radio Spinner ☕️🎶";
            URL="https://live.radiospinner.com/lofi-hip-hop-64"
			break
			;;
		8)
			notification "SmoothChill ☕️🎶";
            URL="https://media-ssl.musicradio.com/SmoothChill"
			break
			;;
    9)
			notification "Lofi TokyoGhoul ☕️🎶";
            URL="https://youtu.be/rNaHDsvjtDw"
			break
			;;
    10)
			notification "Lofi TokyoGhoul Alt ☕️🎶";
            URL="https://youtu.be/8ukM4E7Fs2o"
			break
			;;
    11)
			notification "Lofi TokyoGhoul Playlist ☕️🎶";
            URL="https://youtube.com/playlist?list=PL3Xsq8k7CYjMPh-F15n0ClL14jEBr6S37"
			break
			;;
    12)
			notification "Lofi Cloudy Sakura ☕️🎶";
            URL="https://www.youtube.com/watch?v=IjMESxJdWkg"
			break
			;;
	esac
    # run mpv with args and selected url
    # added title arg to make sure the pkill command kills only this instance of mpv
    mpv $ARGS --title="radio-mpv" $URL --idle="yes" --input-ipc-server=/tmp/mpvsocket --no-video
}

pkill -f radio-mpv || main
