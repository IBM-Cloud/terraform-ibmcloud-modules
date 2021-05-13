# Base Environment

## Summary

This module will give us a base environment that can be reused for tests or for a general purpose environment.&nbsp;  This module can be used to create a base environment that you will be able to build off of for your specific needs.

## Required Inputs and descriptions

Below is a list of variables that can be passed to direct the construction of a base environment:
<table>
    <tr>
        <td>Type</td>
        <td>Name</td>
        <td>Default</td>
        <td>Description</td>
    </tr>
    <tr>
        <td>string</td>
        <td>suffix</td>
        <td>N/A</td>
        <td>The unique identifier for the resources that will be created</td>
    </tr>
    <tr>
        <td>string</td>
        <td>zone</td>
        <td>us-south-1</td>
        <td>The zone that the resources will be created in </td>
    </tr>
    <tr>
        <td>string</td>
        <td>zone_vpc_address_prefix</td>
        <td>N/A</td>
        <td>Zone vpc address prefix map</td>
    </tr>
    <tr>
    <td>string</td>
        <td>bastion_ipv4_cidr</td>
        <td>N/A</td>
        <td>The cidr to use for the bastion hosts</td>
    </tr>
    <tr>
        <td>string</td>
        <td>worker_ipv4_cidr</td>
        <td>N/A</td>
        <td>The cidr to use for the worker hosts</td>
    </tr>   
    <tr>
        <td>string</td>
        <td>resource_group</td>
        <td>Default</td>
        <td>The resource group to use for all of the resources that will be created</td>
    </tr>
    <tr>
        <td>string</td>
        <td>bastion_image_id</td>
        <td>r134-ed3f775f-ad7e-4e37-ae62-7199b4988b00</td>
        <td>The image id that will be used for the bastion host</td>
    </tr>
    <tr>
        <td>string</td>
        <td>profile</td>
        <td>cx2-2x4</td>
        <td>The profile that will be used for the VSIs</td>
    </tr>
    <tr>
        <td>slice</td>
        <td>region_list</td>
        <td>[us-south]</td>
        <td>Regions to create the resources in</td>
    </tr>
    <tr>
        <td>string</td>
        <td>bastion_id</td>
        <td> r134-ed3f775f-ad7e-4e37-ae62-7199b4988b00</td>
        <td>Image id to use for the bastion host</td>
    </tr>
    <tr>
        <td>string</td>
        <td>ubuntu_worker_id</td>
        <td> r134-ed3f775f-ad7e-4e37-ae62-7199b4988b00</td>
        <td>Image id to use for ubuntu worker host</td>
    </tr>
    <tr>
        <td>string</td>
        <td>ubuntu_worker_count</td>
        <td>1</td>
        <td>Number of ubuntu worker VSIs to create </td>
    </tr>
</table>

## Outputs

Below are a table of the outputs that will be returned following the creation of a base environment

<table>
    <tr>
        <td>Name</td>
        <td>Description</td>
    </tr>
    <tr>
        <td>vpc</td>
        <td>The full structure for the VPC</td>
    </tr>
    <tr>
        <td>bastion</td>
        <td>The full structure for the Bastion</td>
    </tr>
    <tr>
        <td>bastion_fip</td>
        <td>Floating IP for the bastion host</td>
    </tr>
    <tr>
        <td>public_key</td>
        <td>The public key that is on the VSIs</td>
    </tr>
    
</table>
