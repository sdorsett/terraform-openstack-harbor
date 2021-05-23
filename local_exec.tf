resource "null_resource" "run-ansible-playbook" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ansible/openstack_inventory.py ansible/site.yml"
  }
  depends_on = [ openstack_compute_instance_v2.harbor ]
}
