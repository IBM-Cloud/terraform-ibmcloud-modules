# Terraform Ibmcloud Modules
Collection of Terraform modules for IBM Cloud that will allow for users to more easily use Terraform to manage resources in the IBMCloud

### Required Packages/Tools ###
1. Terraform >= v0.12.x
2. Terraform IBM Provider >= v1.7.1

### Optional Packages/Tools ###
1. Docker
2. Make

## Required Environment Variables ##
The below is an example of pointing at the IBMCLOUD staging environment
```IBMCLOUD_API_ENDPOINT="https://test.cloud.ibm.com"
IBMCLOUD_IAM_API_ENDPOINT="https://iam.test.cloud.ibm.com"
IBMCLOUD_IS_NG_API_ENDPOINT="us-south-stage01.iaasdev.cloud.ibm.com"
IBMCLOUD_IS_API_ENDPOINT="https://us-south-stage01.iaasdev.cloud.ibm.com"
IBMCLOUD_RESOURCE_CATALOG_API_ENDPOINT="https://globalcatalog.test.cloud.ibm.com"
IBMCLOUD_RESOURCE_MANAGEMENT_API_ENDPOINT="https://resource-controller.test.cloud.ibm.com"
IBMCLOUD_GT_API_ENDPOINT="https://tags.global-search-tagging.test.cloud.ibm.com"
IBMCLOUD_API_KEY=<YOUR_API_KEY>
```

### Convenience Container ###
There is a convenience container that you can build, run tests, and create a bash session with dev packages already installed.  

** IBMCLOUD_API_KEY needs to be set to use the docker container **

#### Building the Container ####
Will build the convenience container
```
make docker-build
```

#### Executing Commands ####
Once on the container you can execute Terraform commands from Terraform created on your local source tree as it will mount the repo directory in the container
```
make debug-container
```

### Executing Tests ###
Will execute all of the tests in the test directory
```
make run-tests
```

## Rules of Engagement
In order to have your additions to the repo merged into main all of the below must happen
* Branch is up to date with master
* All tests need to pass in Travis which can be executed locally by running  
```make run-tests``` 
* PR has been reviewed by at least 1 repo Admin
* The contributor has added a test for any new modules created and/or updated any tests to test the new functionality they are adding

It is the responsibility of the person who submitted the PR to merge into main once all of the requirements above have been met
