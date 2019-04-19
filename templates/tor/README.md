# Tor
* to run `tor -f torrc`
* socks proxy on 9050
* iptable rules, uuid 1071, TransPort 9040
```
iptables -F
iptables -X
iptables -t nat -F

iptables -P INPUT DROP
iptables -P FORWARD DROP
# TODO
iptables -P OUTPUT ACCEPT

# allow established
iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT
# alow loopback
iptables -A INPUT -i lo -j ACCEPT

# don't nat loopback
iptables -t nat -A OUTPUT -o lo -j RETURN

# don't nat tor process
iptables -t nat -A OUTPUT -m owner --uid-owner 1071 -j RETURN

# redirect
iptables -t nat -A OUTPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -j REDIRECT --to-port 9040

# TODO iptables -P OUTPUT DROP and only allow specific tor stuff
#iptables -A OUTPUT -m state --state ESTABLISHED -j ACCEPT
#iptables -A OUTPUT -m owner --uid-owner 1071 -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -m state --state NEW -j ACCEPT

# TODO: dns, allow udp for now
```
