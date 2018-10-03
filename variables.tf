variable "frontendrelease" {
    description = "github release for frontend"
    default = "https://github.com/jsirianni/gocron/releases/download/3.0.3/gocron-front"
}

variable "backendrelease" {
    description = "github release for backend"
    default = "https://github.com/jsirianni/gocron/releases/download/v3.0.5/gocron-back"
}

variable "network_name" {
    description = "primary network for gocron"
    default = "gocron"
}

variable "subnetwork_name" {
    description = "primary subnetwork for frontend and backend"
    default = "gocron-us-east"
}

variable "subnetwork_cidr" {
    description = "gocron subnet"
    default = "10.5.4.0/24"
}

variable "region" {
    description = "default gocron region"
    default = "us-east1"
}

variable "primary_region" {
  default = "us-east1"
}

variable "primary_zone" {
    description = "default gocron region zone"
    default = "us-east1-b"
}
