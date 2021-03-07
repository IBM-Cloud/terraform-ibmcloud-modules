package test

import (
	"fmt"
	"os"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func init() {
	os.Setenv("IBMCLOUD_API_KEY", os.Getenv("IBMCLOUD_API_KEY"))
	os.Setenv("IBMCLOUD_IS_NG_API_ENDPOINT", os.Getenv("IBMCLOUD_IS_NG_API_ENDPOINT"))
	os.Setenv("IBMCLOUD_IAM_API_ENDPOINT", os.Getenv("IBMCLOUD_IAM_API_ENDPOINT"))
	os.Setenv("IBMCLOUD_IS_API_ENDPOINT", os.Getenv("IBMCLOUD_IS_API_ENDPOINT"))
}

// An example of how to test the Terraform module in examples/terraform-aws-example using Terratest.
func TestIbmIsSubnet(t *testing.T) {
	randomCharacters := fmt.Sprintf(strings.ToLower(random.UniqueId()))
	subnet_name := "testing-subnet-" + randomCharacters
	zone := "us-south-1"
	total_ipv4_address_count := 256

	vpc_id, terraformVpcOptions := CreateVPC(t, randomCharacters)

	// website::tag::1::Configure Terraform setting path to Terraform code
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../modules/is_subnet",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"subnet_name": subnet_name,
			"vpc_id":              vpc_id,
			"zone":                zone,
			"total_ipv4_address_count":	total_ipv4_address_count,
		},
	}

	// Run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	// Verify the name is what was set
	ret_subnet_name := terraform.Output(t, terraformOptions, "subnet_name")
	fmt.Println("ret_public_gateway_name: ", ret_subnet_name)
	assert.Equal(t, subnet_name, ret_subnet_name)

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	terraform.Destroy(t, terraformOptions)
	terraform.Destroy(t, terraformVpcOptions)

}
