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


// Begin secure vars, these should be passed in using secure.tfvars
//
variable "project" {
    description = "gocron project name - string"
}

variable "project_id" {
    description = "gocron project id - string"
}

variable "dbport" {
    description = "gocron backing database network port - string"
}

variable "dbuser" {
    description = "gocron backing database user - string"
}

variable "dbpass" {
    description = "gocron backing database user password - string"
}

variable "dbdatabase" {
    description = "gocron.yml config - backing database name - string"
}

variable "smtpserver" {
    description = "gocron smtp server - string"
}

variable "smtpport" {
    description = "gocron smtp server port - string"
}

variable "smtpaddress" {
    description = "gocron smtp user address - string"
}

variable "smtppassword" {
    description = "gocron smtp user password - string"
}

variable "interval" {
    description = "gocron check interval, in seconds. specifies how often to check for missed jobs - string"
}

variable "slackhookurl" {
    description = "slack webhook url, for notifications - string"
}

variable "slackchannel" {
    description = "slack channel, for notifications - string"
}

variable "preferslack" {
    description = "prefer slack instead of smtp, if true. will fall back to smtp if slack fails - string"
}
