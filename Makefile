eastus:
		terraform workspace new  eastus  || terraform workspace select  eastus
		terraform init  
		terraform apply -var-file envs/eastus.tfvars -auto-approve

germanywestcentral:
		terraform workspace new  germanywestcentral  || terraform workspace select  germanywestcentral
		terraform init  
		terraform apply -var-file envs/germanywestcentral.tfvars -auto-approve
all:
		make eastus
		make germanywestcentral

eastus-destroy:
		terraform workspace new  eastus  || terraform workspace select  eastus
		terraform init
		terraform destroy -var-file envs/eastus.tfvars -auto-approve

germanywestcentral-destroy:
		terraform workspace new  germanywestcentral  || terraform workspace select  germanywestcentral
		terraform init
		terraform destroy -var-file envs/germanywestcentral.tfvars -auto-approve

destroy-all:
		make eastus-destroy
		make germanywestcentral-destroy