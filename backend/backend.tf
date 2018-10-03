data "template_file" "backend" {
  template = "${file("${path.module}/backend.sh.tpl")}"
  vars {
      dbfqdn       = "${var.dbfqdn}"
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
      release_url  = "${var.backendrelease}"
  }
}


module "backend_instance_group" {
    name              = "gocron-back-${terraform.workspace}"
    project           = "${var.project}"
    source            = "GoogleCloudPlatform/managed-instance-group/google"
    version           = "1.1.14"

    // location config
    region            = "${var.primary_region}"
    zone              = "${var.primary_zone}"

    // network
    network    = "${var.network}"
    subnetwork = "${var.subnetwork}"

    // machine config
    machine_type      = "f1-micro"
    preemptible       = "false"
    automatic_restart = "true" // must be false when preemptible instances are used
    startup_script    = "${data.template_file.backend.rendered}"
    compute_image     = "projects/debian-cloud/global/images/family/debian-9"

    // instance group config
    autoscaling  = false
    size         = 1
    service_port = 8080
    min_replicas = 1
    max_replicas = 1
    hc_path      = "/healthcheck"
    hc_port      = "8080"
    service_port_name = "gocron-front-${terraform.workspace}"
    http_health_check = false // TODO: no healthcheck service at this time
    target_tags       = ["gocron-front-${terraform.workspace}"]
}
