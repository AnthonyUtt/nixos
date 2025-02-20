#!/run/current-system/sw/bin/bash

function start_hook() {
  # Stops GUI
  systemctl isolate multi-user.target

  # Unbind EFI framebuffer
  echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

  # Avoids race condition
  sleep 2

  # Unloads the NVIDIA drivers
  modprobe -r nvidia_drm
  modprobe -r nvidia_uvm
  modprobe -r nvidia_modeset
  modprobe -r nvidia

  # Other code you might want to run
  modprobe vfio-pci
}

function revert_hook() {
  # Other stuff you might want to revert
  modprobe -r vfio-pci

  # Loads the NVIDIA drivers
  modprobe nvidia
  modprobe nvidia_modeset
  modprobe nvidia_uvm
  modprobe nvidia_drm

  # Bind EFI Framebuffer
  echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/bind

  # Starts the UI again
  systemctl isolate graphical.target
}

GUEST_NAME="$1"
HOOK_NAME="$2"
STATE_NAME="$3"

# I am not using the script from Passthrough-Post
# because hooks option saves it to /var/lib/libvirt/hooks/qemu.d.
# It's simpler to just rewrite it for NixOS.
if [[ "$GUEST_NAME" != "win11" ]]; then
  exit 0
fi

if [[ "$HOOK_NAME" == "prepare" && "$STATE_NAME" == "begin" ]]; then
  start_hook
elif [[ "$HOOK_NAME" == "release" && "$STATE_NAME" == "end" ]]; then
  revert_hook
fi
