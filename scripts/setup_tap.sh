#!/bin/bash

set -e

TAP=tap0
IP=192.168.100.10/24

if ! ip link show "$TAP" >/dev/null 2>&1; then
    sudo ip tuntap add dev "$TAP" mode tap user "$USER"
fi

sudo ip addr replace "$IP" dev "$TAP"
sudo ip link set "$TAP" up

echo "TAP interface configured:"
ip -br addr show "$TAP"
