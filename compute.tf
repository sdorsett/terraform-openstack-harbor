terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}

provider "openstack" {}

data "openstack_images_image_v2" "ubuntu_20_10" {
  name = "Ubuntu 20.10"
  most_recent = true
}

data "openstack_compute_flavor_v2" "s1-2" {
  name = "s1-2"
}

resource "openstack_compute_instance_v2" "harbor" {
  name            = "harbor"
  image_id        = "${data.openstack_images_image_v2.ubuntu_20_10.id}"
  flavor_id       = "${data.openstack_compute_flavor_v2.s1-2.id}"
  key_pair        = "${openstack_compute_keypair_v2.deploy-keypair.name}"
  security_groups = ["${openstack_compute_secgroup_v2.deploy-harbor-allow-external-ports.name}"]

  network {
    name = "Ext-Net"
  }

  provisioner "remote-exec" {
    inline = [
      "#sudo apt-get update && sudo apt-get install python -y",
    ]
    connection {
      host        = coalesce(self.access_ip_v4, self.access_ip_v6)
      type        = "ssh"
      user        = "${var.ssh_user}"
      private_key = "${file(var.private_key)}"
    }
  }

}

