# Procedure to automatically deploy a microservices kubernetes cluster in a vagrant infrastructure using terraform, helmfile, github actions

## Prerequisites
Local ubuntu machine with installed:
- vagrant
- virtualbox
- ansible

## Setup on local host

1. Create a project directory
- `mkdir -p ~/vagrant/kubernetes`

2. Create key-pair (named vagrant_key)
- `ssh-keygen -b 4096`

3. Create following files inside above directory
- Vagrantfile
- hosts
- node-init.yml
- master-node-init.yml
- worker-node-init.yml

4. Run VMs
- `vagrant up`

5. Verify ansible can talk to VMs
- `ansible -i hosts all -m ping`

6. Run ansible playbooks
- `ansible-playbook -i hosts node-init.yml`
- `ansible-playbook -i hosts master-node-init.yml`
- `ansible-playbook -i hosts worker-node-init.yml`

## Setup terraform on master node

1. SSH to master node from local host
- `vagrant ssh k8s-master`

2. Verify kubernetes cluster is up
- `kubectl get nodes`

3. Create terraform directory
- `mkdir -p ~/terraform/kubernetes`

4. Create a new namespace with terraform file inside above directory
- main.tf

5. Apply terraform file
- `terraform init`
- `terraform apply`

6. Security check on terraform file
- `tfsec ~/terraform/kubernetes`

## Setup microservices app with helm on master node

1. Replace helm chart structure with files inside folders:
- charts
- values

2. At the same level of above folders create:
- helmfile.yaml

3. Run the helmfile
- `helmfile sync`

## Setup CD with GitHub actions
