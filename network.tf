resource "openstack_compute_keypair_v2" "deploy-keypair" {
  name       = "terraform-deploy-keypair"
  public_key = "${file(var.public_key)}"
}

resource "openstack_compute_secgroup_v2" "deploy-harbor-allow-external-ports" {
  name        = "deploy-harbor-allow-external-ports"
  description = "permitted inbound external TCP 80, 443 & 4443 traffic"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = -1
    to_port     = -1
    ip_protocol = "icmp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 4443
    to_port     = 4443
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

}

