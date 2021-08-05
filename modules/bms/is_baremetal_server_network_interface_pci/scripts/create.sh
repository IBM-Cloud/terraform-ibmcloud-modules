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

## root@5bcdefa804ae:/sys-rel-2021-4x/tests/features/bms# ic is bm-nicc --help
## NAME:
##     bare-metal-server-network-interface-create - Create a network interface for a bare metal server
##
## USAGE:
##     ibmcloud is bare-metal-server-network-interface-create SERVER
## --subnet SUBNET
## [--name NAME]
## [--interface-type pci | vlan]
## [--ip IPV4_ADDRESS]
## [--security-groups SECURITY_GROUPS]
## [--allowed-vlans ALLOWED_VLANS | --vlan VLAN --allow-interface-to-float false | true]
## [--allow-ip-spoofing false | true]
## [--enable-infrastructure-nat true | false]
## [--output JSON] [-q, --quiet]
##     SERVER: ID of the server.
##
## OPTIONS:
##     --name value                       Name of the network interface
##     --interface-type value             Type of the network interface. One of: pci, vlan. (default: "pci")
##     --subnet value                     Subnet ID for the network interface
##     --ip value                         Primary IPv4 address for the network interface
##     --security-groups value            Comma-separated security group IDs for the network interface
##     --allowed-vlans value              Comma-separated VLAN IDs. Indicates which VLAN IDs (for VLAN interfaces only) can use this PCI interface.
##     --vlan value                       Indicates the 802.1Q VLAN ID tag that must be used for all traffic on this interface (default: 0)
##     --allow-interface-to-float value   Indicates if the interface can float to any other server within the same 'resource_group'. The interface will float automatically if the network detects a GARP or RARP on another bare metal server in the resource group. Applies only to VLAN interfaces. One of: false, true.
##     --allow-ip-spoofing value          Indicates whether source IP spoofing is allowed on the network interface. If 'true', source IP spoofing is allowed on this interface. If 'false', source IP spoofing is prevented on this interface. One of: false, true.
##     --enable-infrastructure-nat value  If true, the VPC infrastructure performs any needed NAT operations. If false, the packet is passed unmodified to/from the network interface, allowing the workload to perform any needed NAT operations. One of: true, false.
##     --output value                     Specify output format, only JSON is supported. One of: JSON.
##     -q, --quiet                        Suppress verbose output
##
##     IBM_REGION                                            = var.ibm_region
##     RESOURCE_GROUP                                        = var.resource_group
##     SUBNET_ID                                             = var.subnet_id
##     SECURITY_GROUP_ID                                     = var.security_group_id
##     BM_SERVER                                             = var.bm_server_id
##     BM_SERVER_NETWORK_INTERFACE_NAME                      = var.bm_server_network_interface_name
##     BM_SERVER_NETWORK_INTERFACE_ID                        = var.bm_server_network_interface_id
##     BM_SERVER_NETWORK_INTERFACE_TYPE                      = var.bm_server_network_interface_type
##     BM_SERVER_NETWORK_INTERFACE_IP                        = var.bm_server_network_interface_ip
##     BM_SERVER_NETWORK_INTERFACE_ALLOWED_VLANS             = var.bm_server_network_interface_allowed_vlans
##     BM_SERVER_NETWORK_INTERFACE_VLAN                      = var.bm_server_network_interface_vlan
##     BM_SERVER_NETWORK_INTERFACE_ALLOW_INTERFACE_TO_FLOAT  = var.bm_server_network_interface_allow_interface_to_float
##     BM_SERVER_NETWORK_INTERFACE_ALLOW_IP_SPOOFING         = var.bm_server_network_interface_allow_ip_spoofing
##     BM_SERVER_NETWORK_INTERFACE_ENABLE_INFRASTRUCTURE_NAT = var.bm_server_network_interface_enable_infrastructure_nat

retry ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP -q
set -ex
ARGUMENTS=""

if [ -n "$BM_SERVER" ]; then
	ARGUMENTS="$ARGUMENTS $BM_SERVER"
fi
if [ -n "$SUBNET_ID" ]; then
	ARGUMENTS="$ARGUMENTS --subnet $SUBNET_ID"
fi
if [ -n "$BM_SERVER_NETWORK_INTERFACE_NAME" ]; then
	ARGUMENTS="$ARGUMENTS --name $BM_SERVER_NETWORK_INTERFACE_NAME"
fi
if [ -n "$BM_SERVER_NETWORK_INTERFACE_TYPE" ]; then
	ARGUMENTS="$ARGUMENTS --interface-type $BM_SERVER_NETWORK_INTERFACE_TYPE"
fi
if [ -n "$BM_SERVER_NETWORK_INTERFACE_IP" ]; then
	ARGUMENTS="$ARGUMENTS --ip $BM_SERVER_NETWORK_INTERFACE_IP"
fi
if [ -n "$SECURITY_GROUP_ID" ]; then
	ARGUMENTS="$ARGUMENTS --security-groups $SECURITY_GROUP_ID"
fi
if [ -n "$BM_SERVER_NETWORK_INTERFACE_ALLOWED_VLANS" ]; then
	ARGUMENTS="$ARGUMENTS --allowed-vlans $BM_SERVER_NETWORK_INTERFACE_ALLOWED_VLANS"
fi
if [ -n "$BM_SERVER_NETWORK_INTERFACE_VLAN" ]; then
	ARGUMENTS="$ARGUMENTS --vlan $BM_SERVER_NETWORK_INTERFACE_VLAN"
fi
if [ -n "$BM_SERVER_NETWORK_INTERFACE_ALLOW_INTERFACE_TO_FLOAT" ]; then
	ARGUMENTS="$ARGUMENTS --allow-interface-to-float $BM_SERVER_NETWORK_INTERFACE_ALLOW_INTERFACE_TO_FLOAT"
fi
if [ -n "$BM_SERVER_NETWORK_INTERFACE_ALLOW_IP_SPOOFING" ]; then
	ARGUMENTS="$ARGUMENTS --allow-ip-spoofing $BM_SERVER_NETWORK_INTERFACE_ALLOW_IP_SPOOFING"
fi
if [ -n "$BM_SERVER_NETWORK_INTERFACE_ENABLE_INFRASTRUCTURE_NAT" ]; then
	ARGUMENTS="$ARGUMENTS --enable-infrastructure-nat $BM_SERVER_NETWORK_INTERFACE_ENABLE_INFRASTRUCTURE_NAT"
fi
ARGUMENTS="$ARGUMENTS --output json"

is_bm_id=$BM_SERVER
is_bm=$(ibmcloud is bm $is_bm_id --output json)
is_bm_status=$(echo $is_bm | jq -r .status)
while [ $is_bm_status = "running" ] || [ $is_bm_status = "pending" ]
do
  ibmcloud is bm-stop -f $is_bm_id
  sleep 30s
  is_bm=$(ibmcloud is bm $is_bm_id --output json)
  is_bm_status=$(echo $is_bm | jq -r .status)
  is_bm_id=$(echo $is_bm | jq -r .id)
done

is_bm_nic=$(echo $ARGUMENTS | xargs ibmcloud is bm-nicc)
ret=$?
if [ $ret -ne 0 ]; then
        exit 1
fi

is_bm_id=$BM_SERVER
is_bm=$(ibmcloud is bm $is_bm_id --output json)
is_bm_status=$(echo $is_bm | jq -r .status)
while [ $is_bm_status = "stopped" ] || [ $is_bm_status = "starting" ]
do
  if [ $is_bm_status = "stopped" ]; then
    ibmcloud is bm-start $is_bm_id
  fi
  sleep 30s
  is_bm=$(ibmcloud is bm $is_bm_id --output json)
  is_bm_status=$(echo $is_bm | jq -r .status)
  is_bm_id=$(echo $is_bm | jq -r .id)
done

echo $is_bm_nic
