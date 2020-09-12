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
func TestIbmIsVPC(t *testing.T) {
	t.Parallel()
	randomCharacters := fmt.Sprintf(strings.ToLower(random.UniqueId()))
	vpc_name := "testing-vpc-" + randomCharacters

	// website::tag::1::Configure Terraform setting path to Terraform code
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../modules/is_vpc",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"vpc_name": vpc_name,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// Run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	// Verify the id is not empty
	ret_vpc_id := terraform.Output(t, terraformOptions, "vpc_id")
	fmt.Println("ret_ibm_is_vpc_id: ", ret_vpc_id)
	assert.NotEmpty(t, ret_vpc_id)

	// Verify the name is what was set
	ret_vpc_name := terraform.Output(t, terraformOptions, "vpc_name")
	fmt.Println("ret_ibm_is_vpc: ", ret_vpc_name)
    assert.Equal(t, vpc_name, ret_vpc_name)

}
