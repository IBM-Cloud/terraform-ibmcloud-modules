#!/bin/bash

function retry {
  local n=1
  local max=5
  local delay=1
  while true; do
    "$@" && break || {
      if [[ $n -lt $max ]]; then
        ((n++))
        echo "Command failed. Attempt $n/$max:"
        sleep $delay;
      else
        echo "The command has failed after $n attempts."
        exit 1
      fi
    }
  done
}

echo "creating..."
IN=$(cat)
echo "stdin: ${IN}"

## root@5bcdefa804ae:/sys-rel-2021-4x/tests/features/bms# ic is bm-nicu --help
## NAME:
##     bare-metal-server-network-interface-update - Update a network interface of a bare metal server
##
## USAGE:
##     ibmcloud is bare-metal-server-network-interface-update
## SERVER
## NIC
## --name NEW_NAME
## [--allow-ip-spoofing false | true]
## [--enable-infrastructure-nat true | false]
## [--allowed-vlans ALLOWED_VLANS]
## [--output JSON] [-q, --quiet]
##     SERVER: ID of the server.
##     NIC:    ID of the network interface.
##
## EXAMPLE:
##     ic is bm-nicu 7d317c32-71f8-4060-9bdc-6c971b0317d4 784e2e4c-0540-4e1a-aba7-a51f9b35ba52 --name eth0 --allow-ip-spoofing true --enable-infrastructure-nat true -allowed-vlans 1,3,5
##     ic is bm-nicu 7d317c32-71f8-4060-9bdc-6c971b0317d4 784e2e4c-0540-4e1a-aba7-a51f9b35ba52 --name ethvlan1 --allow-ip-spoofing true --enable-infrastructure-nat true --output JSON
##
## OPTIONS:
##     --name value                       New name of the network interface
##     --allow-ip-spoofing value          Indicates whether source IP spoofing is allowed on the network interface. If 'true', source IP spoofing is allowed on this interface. If 'false', source IP spoofing is prevented on this interface. One of: false, true.
##     --enable-infrastructure-nat value  If true, the VPC infrastructure performs any needed NAT operations. If false, the packet is passed unmodified to/from the network interface, allowing the workload to perform any needed NAT operations. One of: true, false.
##     --allowed-vlans value              Comma-separated VLAN IDs. Indicates which VLAN IDs (for VLAN interfaces only) can use this PCI interface.
##     --output value                     Specify output format, only JSON is supported. One of: JSON.
##     -q, --quiet                        Suppress verbose output
##
## root@5bcdefa804ae:/sys-rel-2021-4x/tests/features/bms#
##
##     IBM_REGION                                            = var.ibm_region
##     RESOURCE_GROUP                                        = var.resource_group
##     BM_SERVER                                             = var.bm_server_id
##     BM_SERVER_NETWORK_INTERFACE_ID                        = var.bm_server_network_interface_id
##     BM_SERVER_NETWORK_INTERFACE_NAME                      = var.bm_server_network_interface_name
##     BM_SERVER_NETWORK_INTERFACE_ALLOWED_VLANS             = var.bm_server_network_interface_allowed_vlans
##     BM_SERVER_NETWORK_INTERFACE_VLAN                      = var.bm_server_network_interface_vlan
##     BM_SERVER_NETWORK_INTERFACE_ALLOW_IP_SPOOFING         = var.bm_server_network_interface_allow_ip_spoofing
##     BM_SERVER_NETWORK_INTERFACE_ENABLE_INFRASTRUCTURE_NAT = var.bm_server_network_interface_enable_infrastructure_nat

retry ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP -q
set -ex
is_bm_nic_id=$(echo $IN | jq -r .id)
ARGUMENTS=""

if [ -n "$BM_SERVER" ]; then
	ARGUMENTS="$ARGUMENTS $BM_SERVER $is_bm_nic_id"
fi
if [ -n "$BM_SERVER_NETWORK_INTERFACE_NAME" ]; then
	ARGUMENTS="$ARGUMENTS --name $BM_SERVER_NETWORK_INTERFACE_NAME"
fi
if [ -n "$BM_SERVER_NETWORK_INTERFACE_ALLOWED_VLANS" ]; then
	ARGUMENTS="$ARGUMENTS --allowed-vlans $BM_SERVER_NETWORK_INTERFACE_ALLOWED_VLANS"
fi
if [ -n "$BM_SERVER_NETWORK_INTERFACE_VLAN" ]; then
	ARGUMENTS="$ARGUMENTS --vlan $BM_SERVER_NETWORK_INTERFACE_VLAN"
fi
if [ -n "$BM_SERVER_NETWORK_INTERFACE_ALLOW_IP_SPOOFING" ]; then
	ARGUMENTS="$ARGUMENTS --allow-ip-spoofing $BM_SERVER_NETWORK_INTERFACE_ALLOW_IP_SPOOFING"
fi
if [ -n "$BM_SERVER_NETWORK_INTERFACE_ENABLE_INFRASTRUCTURE_NAT" ]; then
	ARGUMENTS="$ARGUMENTS --enable-infrastructure-nat $BM_SERVER_NETWORK_INTERFACE_ENABLE_INFRASTRUCTURE_NAT"
fi
ARGUMENTS="$ARGUMENTS --output json"

is_bm_nic=$(echo $ARGUMENTS | xargs ibmcloud is bm-nicu)
ret=$?
if [ $ret -ne 0 ]; then
        exit 1
fi
echo $is_bm_nic
