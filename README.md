Follow the instructions below to activate each of the utilities, services or config files.

The files in the global folder apply to all Debian distros and hardware.

There are additional hardware-specific or distro-specific directories.

## SSH agent service
The following sets up a service to initialize your ssh agents and add the keys at startup.
1. Copy the `ssh-agent.service` file to `~/.config/systemd/user`. If the directory does not exist, create it.
2. Run The following:
```bash
systemctl --user daemon-reload
systemctl --user enable ssh-agent
systemctl --user start ssh-agent
```
3. Now you can add your ssh keys to the agent using `ssh-add`.
4. If you generate the `ssh-keygen` after the above and put the keys in `~/.ssh` directory, most distros automatically add the keys to the agent.

## Main bash profile (.bashrc)
1. You may find additional functionalities in the `.bashrc` file. You can add them to your own `~/.bashrc`. 
2. Run source .bashrc or open a new terminal to make the changes effective.
