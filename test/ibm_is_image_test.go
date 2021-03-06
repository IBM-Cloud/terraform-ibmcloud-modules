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
func TestIbmIsImage(t *testing.T) {
	//t.Parallel()
	t.Skip()
	randomCharacters := fmt.Sprintf(strings.ToLower(random.UniqueId()))
	image_name := "testing-image-" + randomCharacters
	image_href := "https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img"
	operating_system := "ubuntu-16-04-amd64"

	// website::tag::1::Configure Terraform setting path to Terraform code
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../modules/is_image",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"name":             image_name,
			"href":             image_href,
			"operating_system": operating_system,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// Run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	// Verify the name is what we passed in
	ret_image_name := terraform.Output(t, terraformOptions, "image_name")
	fmt.Println("ret_fip_name: ", ret_image_name)
	assert.Equal(t, image_name, ret_image_name)

}
