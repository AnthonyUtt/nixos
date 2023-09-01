# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "amdgpu" ];
    };
    kernelModules = [ "kvm-amd" "amdgpu" ];
    extraModulePackages = [ ];
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "ext4" "vfat" "nfs" "ntfs" ];
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/c022264d-e837-4370-8c2d-4292c2f7c50d";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/562E-A1AB";
      fsType = "vfat";
    };

  fileSystems."/nfs/share" =
    { device = "hashbrown.utthome.local:/storage/share";
      fsType = "nfs";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/98248e91-539b-4774-a0de-25e6b1a97c85"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # GPU stuff
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
    # extraPackages = [ pkgs.amdvlk ];
    # extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };
  environment.variables.AMD_VULKAN_ICD = "RADV";
  #
  # services.xserver = {
  #   enable = true;
  #   videoDriver = "amdgpu";
  # };
}
