{ pkgs, config, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.mutableUsers = false;
  users.users.anthony = {
    hashedPassword = "$y$j9T$E7ZcyDG8mE.ozvXGK3ZR.0$mojgJ8zWLH1PIJ8gSGKmltZoCBn8ows7LrgfowSQk.D";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "dialout"
      "keys"
    ] ++ ifTheyExist [
      "network"
      "docker"
      "git"
      "input"
      "uinput"
      "libvirtd"
      "kvm"
    ];
    packages = [ pkgs.home-manager ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCiNRY663mo/u2dsdLO6Ocsz07zCFkabnUzUhJ5r3xeU9/jL9OwidExRY4GIzyZf1khGwQxaxy0adE4gccNcNiiTNopE5ARG5fnKbF6bJxgwUXqWXgQFmWPteDIftpJwNSN8q5siKNlBd0Re2HJG1bCrziRVf7Wy6/1HH7iEZRBHKgVetVIfyhjnwDNMx+PpOijHsPpYPlk/pvsNeGqxKeTTpV+AT6+nJbIE3oE2LdOsX40KfwMCNO8e8UV+y7m1Tsy55zWikrUbpR0Pj0qhoZNAENEk613ARS7bFPkrMxhNt/qhUzyqftNceFVCVgjKM7fWWi/W1gszDUKDYIrQKfXHu+yNI/NcWOaAgHw4lJkVJzm+TU3imjW4mcQqjnFggo+6TWen8FPz+6JDK/TWiHuRsJgosj99lWlJ7SpT0fgr4ibupz6XfWwbsMKigqfdxW0lX7xTDmvtpfaY/BMPpeJbe429taJp6SPlvQGi4oe3GlnzkXx3lFROKONxSQ8sZs= anthony@utthome.local"
    ];
  };
}
