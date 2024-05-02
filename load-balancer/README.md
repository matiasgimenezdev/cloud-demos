# What does the Terraform script do?

From the custom image, a template will be created and from that, we can create a managed instance group. This will deploy 3 identical instances based on our custom image. 

It will also inject metadata that will create a static web page that contains the server’s name, internal and external IP. Create a Firewall rule that will allow HTTP traffic to come to that group. This is useful if we want it all to reach our servers. Create a front-end and back-end service fronted by a load balancer and forwarding rules.

# Testing Auto-Healing

You can easily see this in action by going into (Compute Engine / Instance groups / apache-rmig ) and select one of the instance and delete it. You'll see a new one taking its place automatically.

# Testing Auto-Scaling

The stress tool as been installed in the golden image we've baked. To stress an instance and trigger auto-scaling, go into (Compute Engine / Instance groups / apache-rmig ) and click SSH under the Connect option of the instance of your chosing to go in. Once you are inside the instance, just run (stress -c 4) and CPU utilization will spike to 100% on that instance and will trigger auto-scaling after a minute. When you terminate the stress tool, the scale-down process can take up to 10 minutes.

# Instructions

1. `packer validate example.json`
2. `packer build example.json`
3. `terraform init`
4. `terraform plan`
5. `terraform apply`
6. Wait or a bit (few minutes) and open a Browser with the IP of your GCP Load Balancer

-   The IP of your GCP Load Balancer can be found in: Network Services / Load balancing
-   Click on http-lb-url-map and look in the Frontend section, protocol HTTP. You'll see your Public IP there.
-   Open your browser http://frontend_public_ip
-   Hit refresh and you'll see that you are going randomly to your Apache servers

7. Run the stress test

```bash
python3 -m venv ./env
source ./env/bin/activate
pip install -r requirements.txt
python3 runner.py
```

# Cleanup

1. `terraform destroy`
2. Delete your custom image in Compute Engine / Images
