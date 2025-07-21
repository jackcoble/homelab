# Homelab

This repository contains all of the configuration for my homelab, using [Ansible](https://docs.ansible.com/ansible/latest/getting_started/index.html).

My primary server is a Lenovo M920q, running Rocky Linux 10. This will act as my "hypervisor", being managed with Ansible and [Cockpit](https://cockpit-project.org/). The idea is that the base OS of this machine will be as minimal as possible, and all the hard work takes place in virtual machines.

## Bootstrapping a new "Hypervisor" machine

[Download](https://rockylinux.org/download) the latest version of Rocky Linux (I am running v10.0) at this moment in time. Install the OS onto the server, ensuring a sudo user is created.

Then, copy your SSH key over to the newly installed OS, using `ssh-copy-id`.

Once this repository has been cloned to a local machine, Ansible can be used to provision the system to act as a hypervisor.