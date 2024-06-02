### Preventing mouse wake up (disable-mouse-wakeup-service)

1. Determine the device ID of you mouse following these steps.

   a. List wakeup devices using `cat /proc/acpi/wakeup`.

   b. Look for device names that start with either `USB` or `XHC`.

   c. Disable one device at a time and test by putting the system to sleep and checking whether the device of interest is prevented from waking the system up. You can disable/enable the wakeup function of the device by `sudo sh -c 'echo "<device>" > /proc/acpi/wakeup'`.

   d. Once you found the device ID by exclusion trial. Save it to `<device>` string in `/etc/systemd/system/disable-mouse-wakeup-service`. The template is provided.

   e. Enable service by `sudo systemctl enable disable-mouse-wakeup.service`. and start it by `sudo systemctl start disable-mouse-wakeup.service`.

   f. Reboot the system.

   g. This makes the change persistent between system reboots.