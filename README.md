# GoCron Terraform
Terraform that deploys the GoCron project https://github.com/jsirianni/gocron

# Usage

## Create Project
##### export variables
```
# your project id to be created
export GOOGLE_PROJECT=projectid

# your existing billingid
export GOOGLE_BILLING=billingid

# your desired workspace name (prod, dev, qa, etc)
export GOOGLE_WORKSPACE=workspace
```

##### create the project
```
gcloud projects create ${GOOGLE_PROJECT}
```

##### switch to the new project
```
gcloud config set project ${GOOGLE_PROJECT}
```

##### Enable billing
```
gcloud beta billing projects link ${GOOGLE_PROJECT} --billing-account ${GOOGLE_BILLING}
```

##### Enable APIs
```
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable cloudbilling.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable servicenetworking.googleapis.com
```

## Configure terraform.tfvars
Variables that should not be defined in git, must first be manually defined. See `variables.tf`
for variable descriptions.
```
# edit terraform.tfvars
cp terraform.tfvars.example terraform.tfvars
vi terraform.tfvars
```


## Deploy
```
terraform init"
terraform workspace select ${GOOGLE_WORKSPACE} || terraform workspace new ${GOOGLE_WORKSPACE}
terraform plan"
terraform apply"
```

## Destroy
Terraform will cleanup all resources within the project, however, the project will remain as it was not created by Terraform
```
terraform destroy"
```
