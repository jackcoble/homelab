# Homelab

This repository contains all of the configuration for my homelab, using [Ansible](https://docs.ansible.com/ansible/latest/getting_started/index.html).

My primary server is a Lenovo M920q, running Rocky Linux 10. This will act as my "hypervisor", being managed with Ansible and [Cockpit](https://cockpit-project.org/). The idea is that the base OS of this machine will be as minimal as possible, and all the hard work takes place in virtual machines.

## Bootstrapping a new "Hypervisor" machine

[Download](https://rockylinux.org/download) the latest version of Rocky Linux (I am running v10.0) at this moment in time. Install the OS onto the server, ensuring a sudo user is created.

Then, copy your SSH key over to the newly installed OS, using `ssh-copy-id`.

Once this repository has been cloned to a local machine, Ansible can be used to provision the system to act as a hypervisor.

### Creating the new "ansible" account

We do not want the root user account to be exposed for any longer than we require. We want to create a dedicated Ansible user which is used strictly for executing commands it receives. For now, this is a manual step. On the hypervisor host, execute the following via the `root` account:

```bash
# create the new ansible user
useradd --create-home --shell /bin/bash ansible
mkdir -p /home/ansible/.ssh
chmod 700 /home/ansible/.ssh

# copy ssh public key (see SSH Keys table)
echo "<ssh-public-key>" > /home/ansible/.ssh/authorized_keys
chmod 600 /home/ansible/.ssh/authorized_keys
chown -R ansible:ansible /home/ansible/.ssh

# ansible user should have passwordless sudo
cat <<EOF >/etc/sudoers.d/ansible
ansible ALL=(ALL) NOPASSWD:ALL
EOF
chmod 440 /etc/sudoers.d/ansible
```

## Miscellaneous
### SSH Keys

| Host           	| SSH Public Key                                                                   	|
|----------------	|----------------------------------------------------------------------------------	|
| M3 Macbook Air 	| ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOBt423fvkSC8SeKVPPAl3MFpwvzwBZ8XEBd4/KrINoP 	|