// create the database instance
//
resource "google_sql_database_instance" "gocron" {
    name    = "${var.dbname}-${terraform.workspace}"
    project = "${var.project}"
    database_version = "${var.dbversion}"
    region  = "${var.region}"

    settings {
        tier = "${var.size}"
        ip_configuration {
            ipv4_enabled = "true"
            authorized_networks {
                value           = "${var.subnetwork_cidr}"
                name            = "${var.subnetwork_name}"
                expiration_time = "${var.expiration_time}"
            }
        }
    }
}


// create the gocron database
//
resource "google_sql_database" "gocron" {
    project = "${var.project}"
    name      = "gocron"
    instance  = "${google_sql_database_instance.gocron.name}"
}


// create the gocron database user
//
resource "google_sql_user" "users" {
    name     = "${var.dbuser}"
    project  = "${var.project}"
    instance = "${google_sql_database_instance.gocron.name}"
    password = "${var.dbpass}"
}
