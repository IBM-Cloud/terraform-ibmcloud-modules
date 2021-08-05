#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740473
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


set -ex

# Encrypt the image file
ENC_IMAGE_FILE="enc-image-file.qcow2"
wget $BASE_IMAGE_FILE_URL -O $BASE_IMAGE_FILE
qemu-img resize $BASE_IMAGE_FILE +100G
qemu-img convert -O qcow2 \
	--object secret,id=sec,data="$PASSPHRASE"  \
	-o encrypt.format=luks,encrypt.key-secret=sec \
        $BASE_IMAGE_FILE $ENC_IMAGE_FILE

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q
output=$(ibmcloud cos upload --bucket $BUCKET_NAME \
	 --key $KEY \
	 --file $ENC_IMAGE_FILE \
	 --region $REGION \
         --json)
ibmcloud logout

echo $output
