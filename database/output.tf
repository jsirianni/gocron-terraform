output instance_address {
    description = "The IPv4 address of the master database instnace"
    value       = "${google_sql_database_instance.gocron.ip_address.0.ip_address}"
}
