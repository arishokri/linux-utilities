Follow the instructions below to activate each of the utilities, services or config files.

The files in the global folder apply to all Debian distros and hardware.

There are additional hardware-specific or distro-specific directories.

## Main bash profile (.bashrc)
1. You may find additional functionalities in the `.bashrc` file. You can add them to your own `~/.bashrc`. 
2. Run source .bashrc or open a new terminal to make the changes effective.

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

## Battery Charge Threshold
For details on the following see [this article](https://ubuntuhandbook.org/index.php/2024/02/limit-battery-charge-ubuntu/).

1. You can list all of your system batteries through `ls /sys/class/power_supply/`.
2. For each battery found in above your can see the list of available options by listing that battery. For example for `BAT0` you run `ls /sys/class/power_supply/BAT0`.
3. If the main battery has `charge_control_end_threshold` option you can control the charge threshold.
4. Try it by running `sudo sh -c "echo 85 > /sys/class/power_supply/BAT0/charge_control_end_threshold"`. Here we restrict it to 85%. You may need to change `BAT0`.
5. Copy `battery-charge-end-threshold.service` to `/etc/systemd/system/`.
6. Run `systemctl enable battery-charge-end-threshold.service`.
7. Then `systemctl start battery-charge-end-threshold.service`.
9. You can add a shortcut to `.bashrc` to limit and unlimit the battery charge threshold. See the `.bashrc` file for details.