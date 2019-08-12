# terraform-openstack-harbor

Terraform playbook for deploying harbor docker repository on openstack. 

In order to run these Terraform configurations you will need to have:

- An openstack account and openrc.sh file for that account download.
- The python openstack client installed on the deploying system
- Ansible installed on the deploying system

Source the openrc.sh file for your openstack account, provide the password for the Openstack user and run terraform plan to test connecting to your openstack project.
