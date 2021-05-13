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

func TestIbmIsSG(t *testing.T) {
	//t.Parallel()
	randomCharacters := fmt.Sprintf(strings.ToLower(random.UniqueId()))
	sg_name := "test-sg-" + randomCharacters

	vpc_id,terraformVpcOptions := CreateVPC(t, randomCharacters)

	// website::tag::1::Configure Terraform setting path to Terraform code
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../modules/is_security_group",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"security_group_name": sg_name,
			"vpc_id": vpc_id,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)
	defer terraform.Destroy(t, terraformVpcOptions)

	// Run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	// Verify the name is what was set
	ret_sg_name := terraform.Output(t, terraformOptions, "security_group_name")
	fmt.Println("ret_ibm_is_vpc: ", ret_sg_name)
    assert.Equal(t, sg_name, ret_sg_name)

}
