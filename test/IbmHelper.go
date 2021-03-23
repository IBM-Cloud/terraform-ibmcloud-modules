package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"testing"
)

func CreateVPC(t *testing.T, randomCharacters string) (string, *terraform.Options) {
	vpc_name := "test-vpc-" + randomCharacters
	// website::tag::1::Configure Terraform setting path to Terraform code
	terraformVpcOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../modules/is_vpc",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"vpc_name": vpc_name,
		},
	}
	// Run `terraform init` and `terraform apply`
	terraform.InitAndApply(t, terraformVpcOptions)

	// Run `terraform output` to get the value of an output variable
	ret_vpc_id := terraform.Output(t, terraformVpcOptions, "vpc_id")
	return ret_vpc_id, terraformVpcOptions
}
