#* Common variables
REGION=us-east1
ZONE=us-east1-b

#? Connect to the VM instance using SSH
gcloud compute ssh vm3 --zone=us-east1-b --ssh-key-file=./keys/id_rsa_example

#? Connect to the VM instance using SSH.
ssh -i ./keys/id_rsa_example mgimenez@<VM_INSTANCE_IP>

#? List the existing public IP addresses
gcloud compute addresses list

#? Create a public IP address
gcloud compute addresses create <IP_VARIABLE_NAME> --region=$REGION

#? Create an instance
gcloud compute instances create <INSTANCE_NAME> <OPTIONS>

#? Delete an instance 
gcloud compute instances delete <INSTANCE_NAME> --zone=$ZONE