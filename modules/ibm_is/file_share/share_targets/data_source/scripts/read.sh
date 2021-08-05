#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-84025-1615393081
# (c) Copyright IBM Corp. 2021
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


set -ex

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q
output=$(ibmcloud is share-targets $SHARE_ID --output JSON)
ibmcloud logout

echo $output |jq .[0]
