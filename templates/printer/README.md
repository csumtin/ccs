# Printer
* need to disable iptables on host machine!! Basically accept input. Run as root
```
iptables -F
iptables -t nat -F
iptables -X
iptables -P INPUT ACCEPT
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
```
* go to `localhost:631` from host machine and search for printers

* to scan, run `hp-scan --mode=color`
