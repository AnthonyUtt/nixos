{ pkgs, ... }: {
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
            "/dev/input/by-id/usb-tshort_Dactyl_Manuform_4x6_5_thumb_keys-event-kbd",
            "/dev/input/by-id/usb-Logitech_USB_Receiver-event-mouse",
            "/dev/null", "/dev/full", "/dev/zero",
            "/dev/random", "/dev/urandom",
            "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
            "/dev/rtc","/dev/hpet", "/dev/sev"
          ]
        '';
      };
      hooks = {
        qemu = {
          "win11" = ./libvirt-hooks/win11.sh;
        };
      };
    };
    spiceUSBRedirection.enable = true;
  };

  systemd.services.libvirtd = {
    path = let
      env = pkgs.buildEnv {
        name = "qemu-hook-env";
        paths = with pkgs; [
          bash
          libvirt
          kmod
          systemd
          libnotify
        ];
      };
    in [ env ];
  };

  # system.activationScripts.libvirt-hooks.text = ''
  #   ln -Tfs /etc/libvirt/hooks /var/lib/libvirt/hooks
  # '';
  #
  # environment.etc = {
  #   "libvirt/hooks/qemu" = {
  #     source = ./libvirt-hooks/qemu.sh;
  #     mode = "0755";
  #   };
  #   "libvirt/hooks/qemu.d/win11/prepare/begin" = {
  #     source = ./libvirt-hooks/prepare.sh;
  #     mode = "0755";
  #   };
  #   "libvirt/hooks/qemu.d/win11/release/end" = {
  #     source = ./libvirt-hooks/release.sh;
  #     mode = "0755";
  #   };
  # };
}
