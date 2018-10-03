// deploy the gocron compute network
//
module "network" {
    source = "network"
    project = "${var.project}"
    region  = "${var.region}"
    network_name    = "${var.network_name}"
    subnetwork_name = "${var.subnetwork_name}"
    cidr            = "${var.subnetwork_cidr}"
}


// deploy the gocron backing database
//
resource "random_id" "dbname" { byte_length = 3 }
module "database" {
    source  = "database"
    dbname  = "gocron-${random_id.dbname.hex}"
    size    = "db-f1-micro"
    dbversion = "POSTGRES_9_6"
    dbuser  = "${var.dbuser}"
    dbpass  = "${var.dbpass}"
    project = "${var.project}"
    region  = "${var.region}"

    // network to whitelist
    subnetwork_cidr = "0.0.0.0/0"
    subnetwork_name  = "public"
}


// deploy the gocron frontend service
//
module "frontend" {
    source = "frontend"
    project = "${var.project}"

    network        = "${module.network.network_name}"
    subnetwork     = "${module.network.subnetwork_name}"
    primary_zone   = "${var.primary_zone}"
    primary_region = "${var.primary_region}"

    // gocron config vars
    dbfqdn       = "${module.database.instance_address}"
    dbport       = "${var.dbport}"
    dbuser       = "${var.dbuser}"
    dbpass       = "${var.dbpass}"
    dbdatabase   = "${var.dbdatabase}"
    smtpserver   = "${var.smtpserver}"
    smtpport     = "${var.smtpport}"
    smtpaddress  = "${var.smtpaddress}"
    smtppassword = "${var.smtppassword}"
    interval     = "${var.interval}"
    slackhookurl = "${var.slackhookurl}"
    slackchannel = "${var.slackchannel}"
    preferslack  = "${var.preferslack}"
    frontendrelease = "${var.frontendrelease}"
}



// deploy the gocron backend service
//
module "backend" {
    source  = "backend"
    project = "${var.project}"

    network        = "${module.network.network_name}"
    subnetwork     = "${module.network.subnetwork_name}"
    primary_zone   = "${var.primary_zone}"
    primary_region = "${var.primary_region}"

    // gocron config vars
    dbfqdn       = "${module.database.instance_address}"
    dbport       = "${var.dbport}"
    dbuser       = "${var.dbuser}"
    dbpass       = "${var.dbpass}"
    dbdatabase   = "${var.dbdatabase}"
    smtpserver   = "${var.smtpserver}"
    smtpport     = "${var.smtpport}"
    smtpaddress  = "${var.smtpaddress}"
    smtppassword = "${var.smtppassword}"
    interval     = "${var.interval}"
    slackhookurl = "${var.slackhookurl}"
    slackchannel = "${var.slackchannel}"
    preferslack  = "${var.preferslack}"
    backendrelease = "${var.backendrelease}"
}
