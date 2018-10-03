data "template_file" "front_end" {
  template = "${file("${path.module}/frontend.sh.tpl")}"
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
      release_url  = "${var.frontendrelease}"
  }
}


module "frontend_instance_group" {
    name              = "gocron-front-${terraform.workspace}"
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
    preemptible       = "true"
    automatic_restart = "false" // must be false when preemptible instances are used
    startup_script    = "${data.template_file.front_end.rendered}"
    compute_image     = "projects/debian-cloud/global/images/family/debian-9"

    // instance group config
    autoscaling  = true
    size         = 2
    service_port = 8080
    min_replicas = 2
    max_replicas = 5
    autoscaling_cpu = [{ target = 0.6 }]
    hc_path      = "/healthcheck"
    hc_port      = "8080"
    service_port_name = "gocron-front-${terraform.workspace}"
    http_health_check = true // TODO: test this
    target_tags       = ["gocron-front-${terraform.workspace}"]
}


module "gce-lb-http" {
  project = "${var.project}"
  source            = "github.com/GoogleCloudPlatform/terraform-google-lb-http"
  name              = "gocron-front-${terraform.workspace}"
  target_tags       = [
      "gocron-front-${terraform.workspace}"
  ]
  backends          = {
    "0" = [
      {
          group = "${module.frontend_instance_group.instance_group}"
      }
    ],
  }
  backend_params    = [
    # health check path, port name, port number, timeout seconds.
    "/healthcheck,gocron-front-default,8080,10"
  ]
}
