{ pkgs, ... }:
let
  server = "wily-rhino.duckdns.org";
  port = 42660;
in
{
  networking.wg-quick = {
    interfaces = {
      wg0 = {
        autostart = true;
        address = [ "10.215.0.4/32" ];
        listenPort = port;
        dns = [ "10.37.15.254" ];
        privateKeyFile = "/etc/utthome-vpn.key";

        peers = [{
          publicKey = "9NrGYXTdg+5f/8nm68LSs1qOY7yNYZMuajKjKUJ49Vg=";
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "${server}:${builtins.toString port}";
          persistentKeepalive = 25;
        }];

        # postUp = ''
        #   # Mark packets on the wg0 interface
        #   wg set wg0 fwmark 51820
        #
        #   # Forbid anything else which doesn't go through wireguard VPN on
        #   # ipV4 and ipV6
        #   ${pkgs.iptables}/bin/iptables -A OUTPUT \
        #     ! -d 192.168.0.0/16 \
        #     ! -o wg0 \
        #     -m mark ! --mark $(wg show wg0 fwmark) \
        #     -m addrtype ! --dst-type LOCAL \
        #     -j REJECT
        #   ${pkgs.iptables}/bin/ip6tables -A OUTPUT \
        #     ! -o wg0 \
        #     -m mark ! --mark $(wg show wg0 fwmark) \
        #     -m addrtype ! --dst-type LOCAL \
        #     -j REJECT
        # '';
        #
        # postDown = ''
        #   ${pkgs.iptables}/bin/iptables -D OUTPUT \
        #     ! -o wg0 \
        #     -m mark ! --mark $(wg show wg0 fwmark) \
        #     -m addrtype ! --dst-type LOCAL \
        #     -j REJECT
        #   ${pkgs.iptables}/bin/ip6tables -D OUTPUT \
        #     ! -o wg0 -m mark \
        #     ! --mark $(wg show wg0 fwmark) \
        #     -m addrtype ! --dst-type LOCAL \
        #     -j REJECT
        # '';
      };
    };
  };
}
