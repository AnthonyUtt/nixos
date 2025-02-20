#!/run/current-system/sw/bin/bash

# Debugging
exec 19>/home/anthony/win11-release.log
BASH_XTRACEFD=19
set -x

# Unload vfio module
modprobe -r vfio-pci

# Attach GPU devices back to host
virsh nodedev-reattach pci_0000_09_00_0
virsh nodedev-reattach pci_0000_09_00_1
virsh nodedev-reattach pci_0000_09_00_2
virsh nodedev-reattach pci_0000_09_00_3

# Loads the NVIDIA drivers
modprobe nvidia
modprobe nvidia_modeset
modprobe nvidia_uvm
modprobe nvidia_drm

# Bind EFI Framebuffer
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/bind

# Bind VTconsoles
echo 1 > /sys/class/vtconsole/vtcon0/bind
echo 1 > /sys/class/vtconsole/vtcon1/bind

# Starts the UI again
systemctl isolate graphical.target
