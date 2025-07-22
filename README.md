# Homelab

This repository contains all of the configuration for my homelab, using [Ansible](https://docs.ansible.com/ansible/latest/getting_started/index.html).

### Hardware & Software
* Lenovo M920q - i5 8th Gen, 64GB DDR4 RAM, 1TB M.2 SSD
* LSI 9200-8e SAS HBA
* 4x 3TB Seagate HDDs
* Rocky Linux 9.6

## Bootstrapping a new "Hypervisor" machine

Install Rocky Linux 9.6 (via the minimal ISO). Make sure that during the installation process, you enable the root account, give it a password, and allow for password login over SSH. This is only temporary.

We want to perform all Ansible commands through a dedicated user. Copy across the `create-ansible-user.sh` script to the server, and execute it. This will create a new "ansible" user with SSH public keys configured, and have passwordless sudo privileges.

We can now provision the system via Ansible! 🎉

```bash
ansible-playbook site.yml
```