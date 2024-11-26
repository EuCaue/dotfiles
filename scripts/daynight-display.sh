#!/usr/bin/sh
# To get this information use "sudo ddcutil getvcp all"
# Brightness = 10
# Contrast   = 12
# RGB        = 16,18,1A
# Gamma      = Can't be changed via DDCUTIL
# Night light is always on

TIME="$1"


check_with_can_run() {
  if [[ $TIME == "--help" || -z $TIME ]]; then
    echo "Usage: $0 {day|night}"
    echo "This script adjusts the monitor settings for day or night usage."
    exit 0
  fi
  if ! command -v ddcutil &> /dev/null; then
    echo "ddcutil could not be found. Please install it first."
    exit 1
  fi
  if [[ $TIME != "day" && $TIME != "night" ]]; then
    echo "Usage: $0 {day|night}"
    exit 1
  fi
}

check_with_can_run 

run_with_sudo() {
  echo "Running $1"
  sudo ddcutil $1
}

get_monitor_info() {
  run_with_sudo "getvcp 10"
  run_with_sudo "getvcp 12"
  run_with_sudo "getvcp 16"
  run_with_sudo "getvcp 18"
  run_with_sudo "getvcp 1A" &&
  gsettings get org.gnome.settings-daemon.plugins.color night-light-temperature
}

# DAY CONFIG:
# Brightness  = 30-50
# Contrast    = 60-70
# Night Light = ON, adjusting during the day
# Gamma       = Gamma2 to enhance perception in brighter environments
# Color temp  = 50/45/45 or use a 6500K temperature for relaxing tones

if [[ $TIME == "day" ]]; then
  red=50
  green=45
  blue=45
  brightness=85
  contrast=45
  gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature "5500" &&
  light -S 85 &&
  run_with_sudo "setvcp 10 $brightness" &&
  run_with_sudo "setvcp 12 $contrast" &&
  run_with_sudo "setvcp 16 $red" &&
  run_with_sudo "setvcp 18 $green" &&
  run_with_sudo "setvcp 1A $blue" &&
    get_monitor_info 
  exit
fi

# NIGHT CONFIG:
# Brightness  = 10-20
# Contrast    = 50-60
# Night Light = ON, with higher intensity
# Gamma       = Gamma1
# Color temp  = 40/45/50 or use a 5000K temperature
# Ambient light = ON

if [[ $TIME == "night" ]]; then
  red=40
  green=45
  blue=50
  brightness=10
  contrast=50
  notify-send -u critical "NIGHT TIME" "TURN ON THE AMBIENT LIGHT" &&
  gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature "4500" &&
  light -S 45 &&
  run_with_sudo "setvcp 10 $brightness" &&
  run_with_sudo "setvcp 12 $contrast" &&
  run_with_sudo "setvcp 16 $red" &&
  run_with_sudo "setvcp 18 $green"&& 
  run_with_sudo "setvcp 1A $blue"&&
    get_monitor_info 
  exit 
fi
