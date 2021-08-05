#!/bin/bash


set -ex
echo "creating..."
IN=$(cat)
echo "stdin: ${IN}"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP
ibmcloud is target --gen 2

# ic is inc --help
# NAME:
#     instance-create - Create a virtual server instance
#
# USAGE:
#     ibmcloud is instance-create INSTANCE_NAME VPC ZONE_NAME PROFILE_NAME SUBNET --image-id IMAGE_ID [--boot-volume BOOT_VOLUME_JSON | @BOOT_VOLUME_JSON_FILE] [--volume-attach VOLUME_ATTACH_JSON | @VOLUME_ATTACH_JSON_FILE] [--key-ids IDS] [--dedicated-host HOST_ID | --dedicated-host-group HOST_GROUP_ID] [--user-data DATA] [([--security-group-ids SECURITY_GROUP_IDS] [--ipv4 IPV4_ADDRESS] [--allow-ip-spoofing FALSE | TRUE]) | --primary-network-interface PRIMARY_NETWORK_INTERFACE_JSON | @PRIMARY_NETWORK_INTERFACE_JSON_FILE] [--network-interface NETWORK_INTERFACE_JSON | @NETWORK_INTERFACE_JSON_FILE] [--resource-group-id RESOURCE_GROUP_ID | --resource-group-name RESOURCE_GROUP_NAME] [--output JSON] [-i, --interactive] [-q, --quiet]
#     INSTANCE_NAME: Name of the instance.
#     VPC:           ID of the VPC.
#     ZONE_NAME:     Name of the zone.
#     PROFILE_NAME:  Name of the profile.
#     SUBNET:        ID of the subnet

ARGUMENTS="${INSTANCE_NAME} ${VPC_ID} ${ZONE_NAME} ${PROFILE_NAME} ${SUBNET_ID} --image-id ${IMAGE_ID}"

if [ -n "$BOOT_VOLUME" ]; then
	ARGUMENTS="$ARGUMENTS --boot-volume $BOOT_VOLUME"
fi
if [ -n "$VOLUME_ATTACH" ]; then
	ARGUMENTS="$ARGUMENTS --volume-attach $VOLUME_ATTACH"
fi
if [ -n "$KEY_IDS" ]; then
	ARGUMENTS="$ARGUMENTS --key-ids $KEY_IDS"
fi
if [ -n "$DEDICATED_HOST" ]; then
	ARGUMENTS="$ARGUMENTS --dedicated-host $DEDICATED_HOST"
fi
if [ -n "$DEDICATED_HOST_GROUP" ]; then
	ARGUMENTS="$ARGUMENTS --dedicated-host-group $DEDICATED_HOST_GROUP"
fi
if [ -n "$USER_DATA" ]; then
	ARGUMENTS="$ARGUMENTS --user-data $USER_DATA"
fi
if [ -n "$SECURITY_GROUP_IDS" ]; then
	ARGUMENTS="$ARGUMENTS --security-group-ids $SECURITY_GROUP_IDS"
fi
if [ -n "$IPV4" ]; then
	ARGUMENTS="$ARGUMENTS --ipv4 $IPV4"
fi
if [ -n "$ALLOW_IP_SPOOFING" ]; then
	ARGUMENTS="$ARGUMENTS --allow-ip-spoofing $ALLOW_IP_SPOOFING"
fi
if [ -n "$PRIMARY_NETWORK_INTERFACE" ]; then
	ARGUMENTS="$ARGUMENTS --primary-network-interface $PRIMARY_NETWORK_INTERFACE"
fi
if [ -n "$NETWORK_INTERFACE" ]; then
	ARGUMENTS="$ARGUMENTS --network-interface $NETWORK_INTERFACE"
fi
if [ -n "$RESOURCE_GROUP_ID" ]; then
	ARGUMENTS="$ARGUMENTS --resource-group-id $RESOURCE_GROUP_ID"
fi

ARGUMENTS="$ARGUMENTS --output json"

is_allow_ip_spoof_instance=$(echo $ARGUMENTS | xargs ibmcloud is inc)
ibmcloud logout

echo $is_allow_ip_spoof_instance


#     IBM_REGION     = var.ibm_region
#     RESOURCE_GROUP = var.resource_group
#     VPC_ID         = var.vpc_id
#     INSTANCE_NAME             = var.instance_name
#     ZONE_NAME                 = var.zone_name
#     PROFILE_NAME              = var.profile_name
#     SUBNET_ID                 = var.subnet_id
#     IMAGE_ID                  = var.image_id
#     BOOT_VOLUME               = var.boot_volume
#     VOLUME_ATTACH             = var.volume_attach
#     KEY_IDS                   = var.key_ids
#     DEDICATED_HOST            = var.dedicated_host
#     DEDICATED_HOST_GROUP      = var.dedicated_host_group
#     USER_DATA                 = var.user_data
#     SECURITY_GROUP_IDS        = var.security_group_ids
#     IPV4                      = var.ipv4
#     ALLOW_IP_SPOOFING         = var.allow_ip_spoofing
#     PRIMARY_NETWORK_INTERFACE = var.primary_network_interface
#     NETWORK_INTERFACE         = var.network_interface
#     RESOURCE_GROUP_ID         = var.resource_group_id
