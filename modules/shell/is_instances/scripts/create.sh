#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740564
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


set -ex
echo "creating..."
IN=$(cat)
echo "stdin: ${IN}"

# Build json objects
BOOT_VOLUME_JSON=$(jq -n \
	           --arg bv_name        "$BV_NAME" \
	           --arg bv_profile     "$BV_PROFILE" \
                   --arg bv_encryption  "$BV_ENCRYPTION" \
	           '{volume: {profile: {name: $bv_profile}, encryption_key: {crn: $bv_encryption}, name: $bv_name}}')
VOL_JSON=$(jq -n \
           --arg vol_name       "$VOL_NAME" \
	   --arg vol_size       "$VOL_SIZE" \
	   --arg vol_profile    "$VOL_PROFILE" \
	   --arg vol_encryption "$VOL_ENCRYPTION" \
	  '[{volume: {name: $vol_name, capacity: $vol_size|tonumber, profile: {name: $vol_profile}, encryption_key: {crn: $vol_encryption}}}]')
PRIMARY_NIF_JSON=$(jq -n \
		   --arg primary_nif_name "$PRIMARY_NIF_NAME" \
		   --arg subnet_id        "$SUBNET_ID" \
		   --arg sg_id            "$SG_ID" \
		   '{name: $primary_nif_name, subnet: {id: $subnet_id}, security_groups: [{id: $sg_id}]}')

if [ -n "${VOL_ATTACH}" ];then
    if [ -n "${VOL_ID}" ]; then
        VOLUME_ATTACH_JSON=$(jq -n --arg vol_id "$VOL_ID" '[{volume: {id: $vol_id}}]')
    else
        VOLUME_ATTACH_JSON=$VOL_JSON
    fi
else
    VOLUME_ATTACH_JSON=$(jq -n '[]')
fi

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
ibmcloud is target --gen 2
instance=$(ibmcloud is instance-create ${VSI_NAME} ${VPC_ID} ${ZONE} ${PROFILE} \
	   --image-id                  "${IMAGE_ID}" \
           --boot-volume               "${BOOT_VOLUME_JSON}" \
	   --volume-attach             "${VOLUME_ATTACH_JSON}" \
	   --key-ids                   "$KEY_IDS" \
	   --user-data                 "${USER_DATA}" \
	   --primary-network-interface "${PRIMARY_NIF_JSON}" \
	   --resource-group-id         "${RESOURCE_GROUP_ID}" \
	   --output json)
ibmcloud logout

echo $instance
