# terraform-openstack-harbor

Terraform playbook for deploying harbor docker repository on openstack. 
Tested using terraform v0.15.4 on OVHCloud.
Installs Harbor v2.2.2 on an Ubuntu 20.10 instance.

https://goharbor.io/

In order to run these Terraform configurations you will need to have:

- An openstack account and openrc.sh file for that account download.
- The python openstack client installed on the deploying system
- Ansible installed on the deploying system
- The ability to update the FQDN listed in `harbor_fqdn` of vars.yml to point to the external IP address of the deployed openstack instance

Source the openrc.sh file for your openstack account, provide the password for the Openstack user and run terraform plan to test connecting to your openstack project.
