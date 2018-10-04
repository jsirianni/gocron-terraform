variable "size" {}
variable "dbname" {}
variable "dbuser" {}
variable "dbpass" {}
variable "project" {}
variable "region" {}
variable "subnetwork_cidr" {}
variable "subnetwork_name" {}

variable "expiration_time" {
    description = "default experation time: expire in 10 years"
    default = "2028-11-15T16:19:00.094Z"
}

variable "dbversion" {
    description = "default database version is postgres 9.6"
    default = "POSTGRES_9_6"
}
