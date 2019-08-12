provider "openstack" {}

data "openstack_images_image_v2" "ubuntu_18_04" {
  name = "Ubuntu 18.04"
  most_recent = true
}

data "openstack_compute_flavor_v2" "s1-2" {
  name = "s1-2"
}

resource "openstack_compute_instance_v2" "harbor" {
  name            = "harbor"
  image_id        = "${data.openstack_images_image_v2.ubuntu_18_04.id}"
  flavor_id       = "${data.openstack_compute_flavor_v2.s1-2.id}"
  key_pair        = "${openstack_compute_keypair_v2.deploy-keypair.name}"
  security_groups = ["${openstack_compute_secgroup_v2.deploy-harbor-allow-external-ports.name}"]

  network {
    name = "Ext-Net",
  }

  metadata {
    deploy-k8s = "harbor"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update && sudo apt-get install python -y",
    ]
    connection {
      type        = "ssh"
      user        = "${var.ssh_user}"
      private_key = "${file(var.private_key)}"
    }
  }

}

