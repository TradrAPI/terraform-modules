output "const" {
  value = {
    any_port               = 0
    vpn_port               = 1194
    ssh_port               = 22
    https_port             = 443
    http_port              = 80
    node_exporter_port     = 9100
    redis_port             = 6379
    redshift_port          = 5439
    mysql_port             = 3306
    pg_port                = 5432

    tcp_protocol   = "tcp"
    udp_protocol   = "udp"
    any_protocol   = "-1"
    all_ips        = ["0.0.0.0/0"]
    a_record       = "A"
    cname_record   = "CNAME"
  }
}
