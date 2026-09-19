# MN521 Enterprise Network Automation

Enterprise network automation project created using GNS3, Cisco IOS, Ubuntu Linux and Ansible.

## Devices

- R1 - Headquarters
- R2 - Branch Office
- R3 - Data Centre
- R4 - Core Router
- Ubuntu Linux Automation Server

## Management Network

- Ubuntu/tap0: 192.168.100.10/24
- R1: 192.168.100.201
- R2: 192.168.100.202
- R3: 192.168.100.203
- R4: 192.168.100.204

## VLAN Networks

- VLAN 10: 192.168.10.0/24
- VLAN 20: 192.168.20.0/24
- VLAN 30: 192.168.30.0/24
- VLAN 40: 192.168.40.0/24
- VLAN 50: 192.168.50.0/24
- VLAN 60: 192.168.60.0/24
- VLAN 70: 192.168.70.0/24

## Routed Links

- R1-R4: 10.0.14.0/30
- R2-R4: 10.0.24.0/30
- R3-R4: 10.0.34.0/30

## Implemented Features

- Ansible inventory
- Group variables
- Host variables
- Ansible roles
- Hostname automation
- VLAN/subinterface automation
- SSH
- ACL
- OSPF
- NTP
- Syslog
- Security banner
- NAT/PAT configuration

## Setup

### 1. Configure TAP interface

    ./scripts/setup_tap.sh

### 2. Configure NTP and Syslog

    ./scripts/setup_services.sh

### 3. Install required Ansible collections

    cd ansible
    ansible-galaxy collection install -r requirements.yml

### 4. Create inventory

    cp inventory.ini.example inventory.ini

Edit inventory.ini and replace CHANGE_ME with your router password.

### 5. Test Ansible connectivity

    ansible routers -i inventory.ini -m ansible.netcommon.cli_command -a "command='show ip interface brief'"

### 6. Run main automation

    ansible-playbook -i inventory.ini site.yml

### 7. Run security and services automation

    ansible-playbook -i inventory.ini sulav.yml

## Important

Cisco IOS images are not included in this repository because they may be licensed software.

Users must provide their own compatible Cisco IOS images for GNS3.
