#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-88676-1620634890
# (c) Copyright IBM Corp. 2021
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.

set -ex
source ${SCRIPTS_PATH}/functions
IN=$(cat)
echo "stdin: $IN"

# Build boot-volume and volume-attach json objects
tmp_dir=".tmp"
mkdir -p ${tmp_dir}
boot_volume_json_file="./${tmp_dir}/boot-volume-${INSTANCE_NAME}.json"
volume_attach_json_file="./${tmp_dir}/volume-attach-${INSTANCE_NAME}.json"
if [ -n "$BV_SNAPSHOT_ID" ];then
	boot_volume_json=$(jq -n \
		--arg bv_attach_name "$BV_ATTACH_NAME" \
		--arg bv_name "$BV_NAME" \
		--arg bv_profile "$BV_PROFILE" \
		--arg bv_snapshot_id "$BV_SNAPSHOT_ID" \
		'{name: $bv_attach_name, volume: {name: $bv_name, profile: {name: $bv_profile}, source_snapshot: {id: $bv_snapshot_id}}}')
	echo "$boot_volume_json" |jq . >$boot_volume_json_file
fi
if [ -n "$DV_SNAPSHOT_ID" ];then
	volume_attach_json=$(jq -n \
		--arg dv_attach_name "$DV_ATTACH_NAME" \
		--arg dv_deletion $DV_DELETION \
		--arg dv_name "$DV_NAME" \
		--arg dv_profile "$DV_PROFILE" \
		--arg dv_capacity "$DV_CAPACITY" \
		--arg dv_snapshot_id "$DV_SNAPSHOT_ID" \
		'[{name: $dv_attach_name, delete_volume_on_instance_delete: $dv_deletion|test("true"), volume: {name: $dv_name, capacity: $dv_capacity|tonumber, profile: {name: $dv_profile}, source_snapshot: {id: $dv_snapshot_id}}}]')
	echo "$volume_attach_json" |jq . >$volume_attach_json_file
fi

# Build instance-create cmd string
restoration="ibmcloud is instance-create $INSTANCE_NAME $VPC_ID $ZONE_NAME $INSTANCE_PROFILE $SUBNET_ID --security-group-ids $SECURITY_GROUP_ID"
if [ -n "$BV_SNAPSHOT_ID" ]; then
	if [ -n "$DV_SNAPSHOT_ID" ];then
		# Restore from both boot volume and data volume snapshots
		restoration="$restoration --boot-volume @${boot_volume_json_file} --volume-attach @${volume_attach_json_file}"
	else
		# Restore from boot volume snapshot only
		restoration="$restoration --boot-volume @${boot_volume_json_file}"
	fi
elif [ -n "$DV_SNAPSHOT_ID" ]; then
	# Restore from data volume snapshot only
	restoration="$restoration --key-ids $SSH_KEY_ID --image-id $IMAGE_ID --volume-attach @${volume_attach_json_file}"
else
	echo "No snapshots specified!" && exit 101
fi	
restoration="$restoration --output JSON"
echo "${restoration}\n"

cmd="ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q"
retry 5 10 $cmd
output=$($restoration)
echo $output
