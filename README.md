A work in progress

# GoCron Terraform
Terraform that deploys the GoCron project https://github.com/jsirianni/gocron

# Usage

## Create Project
##### export variables
```
export GCP_PROJECT=projectid
export GCP_BILLING=billingid
```

##### create the project
```
gcloud projects create ${GCP_PROJECT}
```

##### switch to the new project

```
gcloud config set project ${GCP_PROJECT}
```

##### Enable billing
```
gcloud beta billing projects link ${GCP_PROJECT} --billing-account ${GCP_BILLING}
```

##### Enable APIs
```
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable cloudbilling.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable servicenetworking.googleapis.com
```

## Deploy
```
terraform init -var-file="secure.tfvars"
terraform plan -var-file="secure.tfvars"
terraform apply -var-file="secure.tfvars"
```

## Destroy
Terraform will cleanup all resources within the project, however, the project will remain as it was not created by Terraform
```
terraform destroy -var-file="secure.tfvars"
```
