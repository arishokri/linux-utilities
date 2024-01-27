## The path to files placed in this folder will be designated here.

1. Place each file in the designated path.
2. Execute action to enable the file.
   | File | System Path | Action(s) On Placement |
   |------|-------------|------------------------|
   | .bashrc | ~/ | source ~/.bashrc |
   | 90-disable-mouse-wakeup.rules | /etc/udev/rules.d/ | sudo udevadm control --reload-rules ; system restart |
