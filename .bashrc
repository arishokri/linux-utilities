# Initializing SSH agents and keys
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
