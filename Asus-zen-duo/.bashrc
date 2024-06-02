
####################################################################
### custom functions and settings.
## backlight management
# Function to sync backlight
function sync-backlight {
  cat "/sys/class/backlight/intel_backlight/brightness" |
    sudo tee /sys/class/backlight/card1-eDP-2-backlight/brightness
}

# Function to watch backlight
# This function requires installation of inotifywait-tools.
function watch-backlight {
  # Check if the watch-backlight process is already running
  if pgrep -f "inotifywait -e modify /sys/class/backlight/intel_backlight/brightness" > /dev/null; then
    echo "watch-backlight is already running."
    return
  fi

  # Start the watch-backlight process in the background
  (
    sync-backlight
    while inotifywait -e modify /sys/class/backlight/intel_backlight/brightness; do
      sync-backlight
    done
  ) &

  echo "watch-backlight started."
}

# Function to stop watch-backlight
function stop-watch-backlight {
  pkill -f "inotifywait -e modify /sys/class/backlight/intel_backlight/brightness"
  echo "watch-backlight stopped."
}

# Export functions to make them available in all shell sessions
export -f sync-backlight
export -f watch-backlight
export -f stop-watch-backlight
