Provisioning an Azure virtual machine scale set running wordpress thru Terraform


# Prerequisites

* [Terraform](https://www.terraform.io)
* [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
* [Azure subscription](https://azure.microsoft.com/en-us/free)

* Amazon Image on CentOS 7 
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7_9-gen2"
    version   = "latest"



# Instructions

This project makes use of a Makefile in order to fully automate the deployment process.
This Makefile has been populated with all the necessary commands, such as terraform init and terraform apply.
This Makefile also uses different environment variables, stored in /envs, to help you deploy resources in multiple regions with a simple line of command.

To deploy, simply run "make $location-name", where $location-name is to be substituted with the desired location as in the example below:
- make eastasia (will create your resources in the  East Asia region)

To destroy resources, we also make use of our Makefile. Follow this example:
- make eastasia-destroy (will destroy your resources in  East Asia)