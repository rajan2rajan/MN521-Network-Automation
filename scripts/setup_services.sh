#!/bin/bash

set -e

sudo apt update
sudo apt install -y chrony rsyslog

sudo mkdir -p /var/log/gns3
sudo chown syslog:adm /var/log/gns3

sudo tee /etc/chrony/conf.d/gns3-server.conf >/dev/null <<'EOT'
allow 192.168.100.0/24
local stratum 8
port 123
EOT

sudo tee /etc/rsyslog.d/20-gns3.conf >/dev/null <<'EOT'
module(load="imudp")
input(type="imudp" port="514")

template(name="GNS3PerHost" type="string" string="/var/log/gns3/%HOSTNAME%.log")
*.* action(type="omfile" dynaFile="GNS3PerHost")
EOT

sudo systemctl enable chrony
sudo systemctl enable rsyslog
sudo systemctl restart chrony
sudo systemctl restart rsyslog

echo "NTP:"
sudo ss -lunp | grep ':123 ' || true

echo "Syslog:"
sudo ss -lunp | grep ':514 ' || true
