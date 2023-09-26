#!/bin/sh

if [ ! -e "/tmp/date" ]; then
	date +'Screencast from %Y-%m-%d %H:%M:%S' >/tmp/date
fi

datetime=$(cat /tmp/date)
dir=$HOME/Videos/Screencasts

menu_start_recording() {
	echo "1, Record"
	echo "2. Record Area"
	echo "3. Record Window"
	echo "4. Stop recording"
}

record_screen() {
	notify-send "Start Recording 🚀🚀" "Recording ${datetime}"
	sleep 0.5 &&
		wl-screenrec --audio --codec avc -b "1 MB" -f "${dir}/${datetime}".mp4
}

record_area() {
	notify-send "Start Recording Area 🚀🚀" "Recording ${datetime}"
	sleep 0.5 &&
		wl-screenrec --audio --codec avc -b "1 MB" -g "$(slurp -d)" -f "${dir}/${datetime}".mp4
}

record_window() {
	hyprvars=$(hyprctl activewindow -j | cut -d' ' -f2- | head -n -1 | tail -n +4)
	jqvars=$(echo -e "{\n$hyprvars\n}" | jq -r ".at,.size" | jq -s "add" | jq '_nwise(4)' | jq -r '"\(.[0]),\(.[1]) \(.[2])x\(.[3])"')
	sleep 2 && wl-screenrec --audio --codec avc -b "1 MB" -g "${jqvars}" -f "${dir}/${datetime}".mp4
}

stop_recording() {
	if [ $(pgrep wl-screenrec) -gt 1 ]; then
		notify-send "Stopped Recording ${datetime}.mp4 🚀🚀" "Path Copied to clipboard!"
		wl-copy "$dir/$datetime".mp4
		rm /tmp/date
		kill -2 $(pgrep wl-screenrec)
		mpv "$(wl-paste)"
	else
		notify-send "No Recording Found"
	fi
}

choice_start_recording=$(menu_start_recording | fuzzel --dmenu -p "Choose a option: " -l 4 | cut -d. -f1)

case $choice_start_recording in
1)
	record_screen
	;;
2)
	record_area
	;;
3)
	record_window
	;;
4)
	stop_recording
	;;
esac
