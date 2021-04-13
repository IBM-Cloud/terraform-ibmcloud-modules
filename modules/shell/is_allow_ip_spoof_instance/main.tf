# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740519
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


resource "shell_script" "is_allow_ip_spoof_instance" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
  }

  environment = {
    IBM_REGION     = var.ibm_region
    RESOURCE_GROUP = var.resource_group
    VPC_ID         = var.vpc_id

    INSTANCE_NAME             = var.instance_name
    ZONE_NAME                 = var.zone_name
    PROFILE_NAME              = var.profile_name
    SUBNET_ID                 = var.subnet_id
    IMAGE_ID                  = var.image_id
    BOOT_VOLUME               = var.boot_volume
    VOLUME_ATTACH             = var.volume_attach
    KEY_IDS                   = var.key_ids
    DEDICATED_HOST            = var.dedicated_host
    DEDICATED_HOST_GROUP      = var.dedicated_host_group
    USER_DATA                 = var.user_data
    SECURITY_GROUP_IDS        = var.security_group_ids
    IPV4                      = var.ipv4
    ALLOW_IP_SPOOFING         = var.allow_ip_spoofing
    PRIMARY_NETWORK_INTERFACE = var.primary_network_interface
    NETWORK_INTERFACE         = var.network_interface
    RESOURCE_GROUP_ID         = var.resource_group_id

  }

}

variable ibm_region {}
variable resource_group {}
variable vpc_id {}
variable zone_name {}
variable profile_name {}
variable subnet_id {}

variable instance_name {}
variable image_id {}
variable boot_volume { default = "" }
variable volume_attach { default = "" }
variable key_ids { default = ""}
variable dedicated_host { default = "" }
variable dedicated_host_group { default = "" }
variable user_data { default = "" }
variable security_group_ids { default = "" }
variable ipv4 { default = "" }
variable allow_ip_spoofing { default = "false" }
variable primary_network_interface { default = "" }
variable network_interface { default = "" }
variable resource_group_id { default = "" }
variable router_depends_on {
  default = []
}

output "is_allow_ip_spoof_instance" {
  value = shell_script.is_allow_ip_spoof_instance.output
}

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
#     SUBNET:        ID of the subnet.
#
#
# OPTIONS:
#     --image-id value                   ID of the image.
#     --boot-volume value                BOOT_VOLUME_JSON|@BOOT_VOLUME_JSON_FILE, boot volume attachment in JSON or JSON file
#     --volume-attach value              VOLUME_ATTACH_JSON|@VOLUME_ATTACH_JSON_FILE, volume attachment in JSON or JSON file, list of volumes
#     --key-ids value                    Comma-separated IDs of SSH keys.
#     --dedicated-host value             The host destination where the instance will be placed. And instance profile must be in memory family.
#     --dedicated-host-group value       The host group destination where the instance will be placed. And instance profile must be in memory family.
#     --user-data value                  data|@data-file. User data to transfer to the virtual server instance
#     --security-group-ids value         Comma-separated security group IDs for primary network interface.
#     --ipv4 value                       Primary IPv4 address for the primary network interface
#     --allow-ip-spoofing value          Indicates whether source IP spoofing is allowed on this interface. If false, source IP spoofing is prevented on this interface. If true, source IP spoofing is allowed on this interface. Enumeration type: FALSE, TRUE.
#     --primary-network-interface value  PRIMARY_NETWORK_INTERFACE_JSON|@PRIMARY_NETWORK_INTERFACE_JSON_FILE, primary network interface in JSON or JSON file
#     --network-interface value          NETWORK_INTERFACE_JSON|@NETWORK_INTERFACE_JSON_FILE, network interface attachment in JSON or JSON file
#     --resource-group-id value          ID of the resource group. This option is mutually exclusive with --resource-group-name
#     --resource-group-name value        Name of the resource group. This option is mutually exclusive with --resource-group-id
#     --output value                     Specify output format, only JSON is supported now. Enumeration type: JSON.
#     --interactive, -i                  Supply the parameters under interactive mode. This option is mutually exclusive with all other arguments and options.
#     -q, --quiet                        Suppress verbose output
#
#
# EXAMPLE:
#     ibmcloud is instance-create my-instance-name 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 us-south-1 bx2-2x8 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 --image-id r123-72b27b5c-f4b0-48bb-b954-5becc7c1dcb8
#     ibmcloud is instance-create my-instance-name 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 us-south-1 bx2-2x8 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 --image-id r123-72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 --volume-attach '[{"volume": {"name":"my-volume-name", "capacity":10, "profile": {"name": "general-purpose"}}}]'
#       -Create instance with volume attachment.
#     ibmcloud is instance-create my-instance-name 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 us-south-1 bx2-2x8 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 --image-id r123-72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 --volume-attach '[{"volume": {"id":"67531475-bd8a-478e-bcfe-2e53365cd0aa"}}]'
#       -Create instance with existing volume in volume attachment.
#     ibmcloud is instance-create my-instance-name 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 us-south-1 bx2-2x8 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 --image-id r123-72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 --key-ids 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8,72b27b5c-f4b0-48bb-b954-5becc7c1dcb3
#       -Create instance with multiple SSH keys.
#     ibmcloud is instance-create my-instance-name 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 us-south-1 bx2-2x8 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 --image-id r123-72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 --boot-volume '{"name": "boot-vol-name", "volume": {"profile": {"name": "general-purpose"},"encryption_key": {"crn": "crn:v1:bluemix:public:kms:us-south:adffc98a0f1f0f95f6613b3b752286b87:e4a29d1a-2ef0-42a6-8fd2-350deb1c647e:key:5437653b-c4b1-447f-9646-b2a2a4cd6179"}}}'
#       -Create instance with encrypted boot volume.
#     ibmcloud is instance-create my-instance-name 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 us-south-1 bx2-2x8 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 --image-id r123-72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 --network-interface '[{"name": "secondary-nic", "allow_ip_spoofing": true, "subnet": {"id":"72b27b5c-f4b0-48bb-b954-5becc7c1dcb3"}, "security_groups": [{"id": "72b27b5c-f4b0-48bb-b954-5becc7c1dcb8"}, {"id": "72b27b5c-f4b0-48bb-b954-5becc7c1dcb3"}]}]'
#       -Create instance that is attached to secondary network interface.
#     ibmcloud is instance-create my-instance-name 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 us-south-1 bx2-2x8 --image-id r123-72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 --primary-network-interface '{"name": "primary-nic", "allow_ip_spoofing": true, "subnet": {"id":"72b27b5c-f4b0-48bb-b954-5becc7c1dcb3"}, "primary_ipv4_address": "10.240.129.10", "security_groups": [{"id": "72b27b5c-f4b0-48bb-b954-5becc7c1dcb8"}, {"id": "72b27b5c-f4b0-48bb-b954-5becc7c1dcb3"}]}'
#       -Create instance with primary network interface configuration in JSON.
#     ibmcloud is instance-create my-instance-name 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 us-south-1 bx2-2x8 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 --image-id r123-72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 --security-group-ids 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8,72b27b5c-f4b0-48bb-b954-5becc7c1dcb3 --ipv4 10.240.129.10 --allow-ip-spoofing true
#       -Create instance with primary network interface configuration that includes security groups, primary IPv4 address, source IP spoofing setting.
#     ibmcloud is instance-create my-instance-name 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 us-south-1 mx2-2x16 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 --image-id r123-72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 --dedicated-host c019b1f7-c4d6-430c-aaa4-e0cc25d47277
#       -Create instance to be placed to the desired dedicated host.
#     ibmcloud is instance-create my-instance-name 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 us-south-1 mx2-2x16 72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 --image-id r123-72b27b5c-f4b0-48bb-b954-5becc7c1dcb8 --dedicated-host-group a4738ceb-5e59-4601-849a-61d7895740ee
#       -Create instance to be placed to the desired dedicated host group.
#     ibmcloud is instance-create --interactive
#       -Create instance interactively.
