#!/usr/bin/env bash

DOMAIN="vpns.uolinc.com"
HOSTS_FILE="/etc/hosts"
MARKER="# vpn-auto-pin"

# how many resolution attempts (to collect rotating IPs)
ATTEMPTS=10

echo "Collecting IPs for $DOMAIN..."

IPS=()

for i in $(seq 1 $ATTEMPTS); do
    resolved=$(dig +short "$DOMAIN" | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$')
    for ip in $resolved; do
        IPS+=("$ip")
    done
done

# unique + sort numerically
UNIQUE_IPS=$(printf "%s\n" "${IPS[@]}" | sort -u -t . -k1,1n -k2,2n -k3,3n -k4,4n)

echo "All discovered IPs:"
echo "$UNIQUE_IPS"

# pick the "highest cluster"
# simplest approach: take top half of sorted list and choose highest IP
COUNT=$(echo "$UNIQUE_IPS" | wc -l)

if [ "$COUNT" -eq 0 ]; then
    echo "No IPs found!"
    exit 1
fi

# pick highest IP (good enough for your described clustering)
SELECTED_IP=$(echo "$UNIQUE_IPS" | tail -n 1)

echo "Selected IP: $SELECTED_IP"

# remove old entries
sudo sed -i.bak "/$DOMAIN $MARKER/d" "$HOSTS_FILE"

# add new entry
echo "$SELECTED_IP $DOMAIN $MARKER" | sudo tee -a "$HOSTS_FILE" > /dev/null

echo "Updated /etc/hosts with $SELECTED_IP"
notify-send "VPN IP Updated" "Mapped $DOMAIN to $SELECTED_IP"
