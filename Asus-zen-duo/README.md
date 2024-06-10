# Tools for Asus Zenbook Duo UX482EA

You can find a few useful tweaks and driver workaround/fixes in [this repo](https://github.com/alesya-h/zenbook-duo-2024-ux8406ma-linux).

Most of these are aimed for Gnome.

## Bottom Screen Toggle
The removal of detachable keyboard by default does not trigger on-off switch of the bottom monitor. The bottom monitor remains on unless disabled by user.

1. Build and compile the gnome-monitor-config from [this repo](https://github.com/jadahl/gnome-monitor-config).

    a. I have included the compiled version of it for Ubuntu 24.04 in `gnome-monitor-config`.
2. Place this binary executable file in `/usr/local/bin` or any other bin in your `$PATH` that you keep your custom scripts.
3. You can run this executable file with `gnome-monitor-config --help` to see a list of available options (see above link).
4. Run `gnome-monitor-config list` to get a list of monitors and configurations. In our scripts we will be using the `set` option from this tool to set the appropriate display on.
5. The keyboard detach triggers `WLAN` keyboard shortcut. You can remove the functionality of this shortcut from the system by removing the key code from `media-keys`. Here is one way to do it:
    
    a. Run `sudo apt install dconf-editor` if you don't have this tool.
    
    b. Edit the key `/org/gnome/settings-daemon/plugins/media-keys/rfkill-static` and remove the `XF86WLAN` from the list.
    
    c. Log out and back in the system.
6. Open the `duo-functions` script included and set the correct resolution in the top of the file.
7. Store this script somewhere you keep your custom scripts.
8. Settings -> Keyboard -> (at the bottom) Keyboard Shortcuts -> View and Customize Shortcuts -> Custom Shortcuts and press +.

    a. Pick a name for this shortcut.

    b. In the command put `<path_to_this_duo_file> set-displays`.

    c. For setting the shortcut, attach and detach the keyboard so it registers it as the keybinding.

    d. Press add.

    e. Log out and log back in.

9. In order to automatically disable the bottom screen at the GUI login, modify the `screen-toggle.desktop` and put it in the `~/.config/autostart/` directory (create if doesn't exist).

## Brightness Sync
Normally you can only change the brightness of the upper display and have to GUI control over the brightness of the bottom display.
* You can change sync the brightness of the bottom screen by using `sync-backlight` from `duo-functions`.
* Alternatively the `watch-backlight` starts a process that constantly keeps them in sync.
    * This function requires installation of inotifywait package through `sudo apt install inotify-tools`.

These functions require sudo privileges to run. There are a few ways you can make this work, here is one for Ubuntu:

Here we simply edit visudo and let sudo run specific commands without password provision (proceed with caution).

`sudo visudo`

Add the following two lines to the file. Replace the `username` with yours and you may need to adjust `card1-eDP-2-backlight` with the appropriate value for your system (to get your monitor ids refer to the gnome-monitor-config above).

```
username ALL=(ALL) NOPASSWD: /usr/bin/tee /sys/class/backlight/card1-eDP-2-backlight/brightness
username ALL=(ALL) NOPASSWD: /usr/bin/inotifywait -e modify /sys/class/backlight/intel_backlight/brightness
```

* You can run the commands directly using the `duo-functions` as a script.
* You can also copy the `brightness-sync-service` to `/etc/systemd/system/` and start a service.
* But I want more control over this function and I might not always want to have this service running. So instead I add the functionalities directly to the `.bashrc` provided here.
* Make sure that these functions are **executed as `sudo` (see above)**.

## Disable VRR
If Variable Refresh Rate (VRR) for the screen is causing any issues with the system or eyes trains, you can follow these steps to disable it on startup. We basically need to pass `i915.enable_psr=0 amdgpu.vrr_support=0` to kernel on startup.

1. Edit the GRUB config file in `/etc/default/grub`.
2. Find the line that starts with `GRUB_CMDLINE_LINUX_DEFAULT` and add the following to the end of the line: `i915.enable_psr=0`. So it should look like this `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash i915.enable_psr=0"`.
3. Update GRUB using `sudo update-grub`.
4. Reboot the system.
5. Make sure the command is passed to kernel by `cat /proc/cmdline`.