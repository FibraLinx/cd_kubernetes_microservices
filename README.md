# Procedure to automatically deploy a microservices kubernetes cluster in a vagrant infrastructure using terraform, helmfile, jenkins

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
- jenkins.yml

4. Run VMs
- `vagrant up`

5. Verify ansible can talk to VMs
- `ansible -i hosts all -m ping`

6. Run ansible playbooks
- `ansible-playbook -i hosts node-init.yml`
- `ansible-playbook -i hosts master-node-init.yml`
- `ansible-playbook -i hosts worker-node-init.yml`
- `ansible-playbook -i hosts jenkins.yml`

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
- `helmfile apply`

4. Check microservice homepage is reachable
- `kubectl get svc`
- `frontend                NodePort    <IP_ADDRESS>    <none>        80:32424/TCP`
- from physical host browse to <YOUR_WORKER_IP_ADDRESS>:32424

## Setup CD with Jenkins
1. Browse to jenkins (with my current IP setup 192.168.56.13:8080) and complete setup
2. Create a new pipeline and connect your git repository
3. Install SSH plugin
4. Create a new SSH key pair in Jenkins server `ssh-keygen`
5. From Jenkins UI create new credentials of type "SSH Username with private key":
   - call it "k8s"
   - paste private key created in previous step
6. Paste the public key from above created key-pair to host k8s-master in ~./ssh/authorized_keys
7. Run the pipeline
