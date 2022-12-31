# Install iptables For A Configuarable Firewall
pacman --noconfirm --needed -S iptables

# Configure Basic Stateful Firewall
echo -e '*filter\n:INPUT DROP [0:0]\n:FORWARD DROP [0:0]\n:OUTPUT ACCEPT [0:0]\n:TCP - [0:0]\n:UDP - [0:0]\n\n# Drop All Un-Established Connections\n-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT\n-A INPUT -i lo -j ACCEPT\n-A INPUT -m conntrack --ctstate INVALID -j DROP\n-A INPUT -p icmp -m icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT\n-A INPUT -p udp -m conntrack --ctstate NEW -j UDP\n-A INPUT -p tcp --tcp-flags FIN,SYN,RST,ACK SYN -m conntrack --ctstate NEW -j TCP\n-A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable\n-A INPUT -p tcp -j REJECT --reject-with tcp-reset\n-A INPUT -j REJECT --reject-with icmp-proto-unreachable\nCOMMIT' > /etc/iptables/iptables.rules

echo -e '*filter\n:INPUT DROP [0:0]\n:FORWARD DROP [0:0]\n:OUTPUT ACCEPT [0:0]\n:TCP - [0:0]\n:UDP - [0:0]\n\n# Drop All Un-Established Connections\n-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT\n-A INPUT -i lo -j ACCEPT\n-A INPUT -m conntrack --ctstate INVALID -j DROP\n-A INPUT -s fe80::/10 -p ipv6-icmp -j ACCEPT\n-A INPUT -p udp --sport 547 --dport 546 -j ACCEPT\n-A INPUT -p udp -m conntrack --ctstate NEW -j UDP\n-A INPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -m conntrack --ctstate NEW -j TCP\n-A INPUT -p udp -j REJECT --reject-with icmp6-adm-prohibited\n-A INPUT -p tcp -j REJECT --reject-with tcp-reset\n-A INPUT -j REJECT --reject-with icmp6-adm-prohibited\n-A INPUT -p ipv6-icmp -m icmp6 --icmpv6-type 128 -m conntrack --ctstate NEW -j ACCEPT\nCOMMIT' > /etc/iptables/ip6tables.rules

iptables-restore /etc/iptables/iptables.rules
ip6tables-restore /etc/iptables/ip6tables.rules

# Enable iptables Service
systemctl enable iptables.service