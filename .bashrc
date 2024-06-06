## SSH agent initialization.
# Do not use the following lines if you're using the ssh-agent service.
# Initializing SSH agents and keys if you're not using the service.
# starting ssh agent
if [ -z "$SSH_AUTH_SOCK" ] || [ -z "$SSH_AGENT_PID" ]; then 
  eval "$(ssh-agent -s)"
else
  echo "SSH agent with PID ${SSH_AGENT_PID} has already started"
fi

# adding ssh keys as agent identities
if ! ssh-add -l &>/dev/null; then
  ssh-add
else
  echo "SSH agent has identity(s):"
  ssh-add -l
fi
## Custom shortcuts
# Setting and removing charge_limits on battery
alias battery_preserve_on='sudo sh -c "echo 85 > /sys/class/power_supply/BAT0/charge_control_end_threshold"'
alias battery_preserve_off='sudo sh -c "echo 99 > /sys/class/power_supply/BAT0/charge_control_end_threshold"'