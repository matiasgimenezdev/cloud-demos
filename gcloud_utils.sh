#* Common variables
REGION=us-east1
ZONE=us-east1-b
USERNAME="johndoe"

#? Generate a SSH key pair
ssh-keygen -t rsa -b 4096 -C "${USERNAME}@example.com" -f ./keys/id_rsa_example -q -N ""

#? List GCP active projects
gcloud projects list

#? Set actual project
gcloud config set project <PROJECT_ID>

#? Connect to the VM instance using SSH
gcloud compute ssh vm3 --zone=us-east1-b --ssh-key-file=./keys/id_rsa_example

#? Connect to the VM instance using SSH.
ssh -i .keys/id_rsa_example johndoe@<VM_INSTANCE_IP>

#? List the existing public IP addresses
gcloud compute addresses list

#? Create a public IP address
gcloud compute addresses create <IP_VARIABLE_NAME> --region=$REGION

#? Create an instance
gcloud compute instances create <INSTANCE_NAME> <OPTIONS>

#? Delete an instance 
gcloud compute instances delete <INSTANCE_NAME> --zone=$ZONE
