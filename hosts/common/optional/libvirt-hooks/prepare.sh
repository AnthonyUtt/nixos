#!/run/current-system/sw/bin/bash

# Debugging
exec 19>/home/anthony/win11-prepare.log
BASH_XTRACEFD=19
set -x

# Stops GUI
systemctl isolate multi-user.target

# Unbind VTconsoles
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind

# Unbind EFI Framebuffer
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

# Avoids race condition
sleep 5

# Unloads the NVIDIA drivers
modprobe -r nvidia_drm
modprobe -r nvidia_uvm
modprobe -r nvidia_modeset
modprobe -r nvidia

# Detach GPU devices from host
virsh nodedev-detach pci_0000_09_00_0
virsh nodedev-detach pci_0000_09_00_1
virsh nodedev-detach pci_0000_09_00_2
virsh nodedev-detach pci_0000_09_00_3

# Load vfio module
modprobe vfio-pci
