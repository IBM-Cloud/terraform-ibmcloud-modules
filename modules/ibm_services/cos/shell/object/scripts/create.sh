#!/bin/bash


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
