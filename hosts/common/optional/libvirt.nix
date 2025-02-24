{ pkgs, ... }:
let
  start-win11-vm = pkgs.writeShellScriptBin "startvm" ''
    #! /usr/bin/env nix-shell
    #! nix-shell -i bash -p libvirt
  
    exec 19>/home/anthony/startvm.log
    BASH_XTRACEFD=19
    set -ex

    # Stops GUI
    systemctl stop display-manager.service

    # Unbind VTconsoles: might not be needed
    echo 0 > /sys/class/vtconsole/vtcon0/bind
    echo 0 > /sys/class/vtconsole/vtcon1/bind

    # Unbind EFI framebuffer
    echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

    # Avoids race condition
    sleep 2

    # Unloads the NVIDIA drivers
    modprobe -r nvidia_drm
    modprobe -r nvidia_uvm
    modprobe -r nvidia_modeset
    modprobe -r nvidia

    # Detach GPU devices from host
    # Use your GPU and HDMI Audio PCI host device
    virsh nodedev-detach pci_0000_09_00_0
    virsh nodedev-detach pci_0000_09_00_1
    virsh nodedev-detach pci_0000_09_00_2
    virsh nodedev-detach pci_0000_09_00_3

    # Other code you might want to run
    modprobe vfio_pci

    # Start the VM
    virsh start win11
  '';
in {
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [(pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd];
        };
        verbatimConfig = ''
          cgroup_device_acl = [
            "/dev/input/by-id/KEYBOARD_NAME",
            "/dev/input/by-id/MOUSE_NAME",
            "/dev/null", "/dev/full", "/dev/zero",
            "/dev/random", "/dev/urandom",
            "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
            "/dev/rtc","/dev/hpet", "/dev/sev"
          ]
        '';
      };
    };
    spiceUSBRedirection.enable = true;
  };

  environment.systemPackages = [
    start-win11-vm
  ];

  services.udev.extraRules = ''
    SUBSYSTEM=="vfio", OWNER="root", GROUP="kvm"
  '';

  boot = {
    initrd = {
      availableKernelModules = [
        "vfio"
        "vfio_iommu_type1"
        "vfio_pci"
      ];
      kernelModules = [
        "kvm_amd"
        "vfio"
        "vfio_iommu_type1"
      ];
    };
    kernelParams = [
      "amd_iommu=on"
      "iommu=pt"
      "default_hugepagesz=1G"
      "hugepagesz=1G"
      "hugepages=16"
    ];
    kernelModules = [
      "kvm_amd"
      "vfio"
      "vfio_iommu_type1"
    ];
  };
}
