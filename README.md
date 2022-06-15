•	Use Terraform or Ansible or CloudFormation to automate the following tasks against any cloud provider platform, e.g. AWS, GCP, Aliyun.
•	Provision a new VPC and any networking related configurations.
•	In this environment provision a virtual machine instance, with an OS of your choice.
•	Apply any security hardening (OS, firewall, etc..) you see fit for the VM instance.

terraform/main.tf

•	Install Docker CE on that VM instance.

ansible/installDockerCE.yaml

•	Deploy/Start an Nginx container on that VM instance.

ansible/deployNginxDocker.yaml

•	Demonstrate how you would test the healthiness of the Nginx container.

wget http://welendsre.koreacentral.cloudapp.azure.com/

docker ps

•	Expose the Nginx container to the public web on port 80.

ansible/deployNginxDocker.yaml


•	Fetch the output of the Nginx container’s default welcome page.
•	Excluding any HTML/JS/CSS tags and symbols, output the words and their frequency count for the words that occurred the most times on the default welcome page.

ansible/NginxWelcomeFre.yaml


•	Demonstrate how you would log the resource usage of the containers every 10 seconds.

#############
#!/bin/bash
while true
do
  date >> dockerStats.log
  docker stats --no-stream >> dockerStats.log
  sleep 10
done
##############

