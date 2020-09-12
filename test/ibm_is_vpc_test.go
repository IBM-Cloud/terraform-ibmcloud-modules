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
	os.Setenv("IBMCLOUD_IS_NG_API_ENDPOINT", "us-south-stage01.iaasdev.cloud.ibm.com")
	os.Setenv("IBMCLOUD_IAM_API_ENDPOINT", "https://iam.test.cloud.ibm.com")
	os.Setenv("IBMCLOUD_IS_API_ENDPOINT", "https://us-south-stage01.iaasdev.cloud.ibm.com")
}

var resource_group_id = ""

func TestIBMResourceGroup(t *testing.T) {
	//t.Skip()
	t.Parallel()

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../modules/ibm/resource_group_id",
	}

	// Run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)
	terraform.Plan(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	ibm_is_resource_group_id := terraform.Output(t, terraformOptions, "ibm_resource_group_id")
	assert.NotEmpty(t, ibm_is_resource_group_id)

	ibm_is_resource_group := terraform.Output(t, terraformOptions, "ibm_resource_group")
	assert.Contains(t, ibm_is_resource_group, "Default")

}

// An example of how to test the Terraform module in examples/terraform-aws-example using Terratest.
func TestIbmIsVPC(t *testing.T) {
	//t.Skip()
	t.Parallel()
	randomPrefix := "test-" + fmt.Sprintf(strings.ToLower(random.UniqueId())) + "-"
	vpc_name := randomPrefix + "vpc"

	// website::tag::1::Configure Terraform setting path to Terraform code
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../modules/ibm/is_vpc",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"ibm_is_vpc_name": vpc_name,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// Run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	ret_ibm_is_vpc_id := terraform.Output(t, terraformOptions, "ibm_is_vpc_id")
	fmt.Println("ret_ibm_is_vpc_id: ", ret_ibm_is_vpc_id)
	assert.NotEmpty(t, ret_ibm_is_vpc_id)

	// all of terraform output
	ret_vpc := terraform.Output(t, terraformOptions, "ibm_is_vpc")
	fmt.Println("ret_ibm_is_vpc: ", ret_vpc)

	// Verify the name from the output
	assert.Contains(t, ret_vpc, vpc_name)
}
