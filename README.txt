This is a sample implementation of a segmented AWS environment which is deployed in terraform.

To run the script yourself, you'll need to do the following: 

1. Have terraform and AWS CLI installed on your local machine
2. Create an SSH keypair with the command: 

$ ssh-keygen -t rsa -b 4096 -f ~/.ssh/netsec_jump_box_key

3. To connect for testing you can do the following: 

-Run the following terraform commands: 

    terraform init 
    terraform plan
    terraform apply

-The output block in ec2_instances.tf should cause the script to output
the public IP address of the jump box, which you will need to connect
via SSH. 

-If all goes well, connect to your jump box using SSH agent forwarding.
You can run the following to start the SSH agent and pass your private 
key to the  agent on your local machine: 

    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/netsec_jump_box_key

To connect you can run: 

    ssh -A -i ~/.ssh/netsec_jump_box_key ubuntu@<jump-box-public-ip>

using the jump box IP that the script outputs. Note that as we have 
configured this, the public IP of the jump box may change when you shut 
it off and restart it. In order to have a persistent public IP, we have
to modify our script to provision an AWS elastic ip address, which would
incur additional costs, but you can certainly try out. 

-Once we've connected to the jump box, we can SSH into box A as follows: 

    ssh ubuntu@10.0.2.30

(Note that 10.0.2.30 is the IP we assigned to box A, which is specified in 
vars.tf. The credential management will be automatically performed by your
SSH agent.)

-Finally, we can test out connectivity to Box B. We have configured Box B 
to only allow connections on port 8000 from box A. This is simulating calls
to a backend API, but in a real scenario we would want to add additional 
security here by using HTTPS, which would require creating a certificate 
and using TLS to connect. We have configured A to run a startup script that 
starts a simple http server on port 8000. We can connect to from box A it via: 

    curl http://10.0.2.31:8000

and the expected response is: 





