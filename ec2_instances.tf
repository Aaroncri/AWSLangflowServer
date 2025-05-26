#########################################################
###############      Jump Box       #####################
#########################################################

resource "aws_instance" "jump_box" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.jump_box_key.key_name
  vpc_security_group_ids = [aws_security_group.SG_jump_box.id]
  subnet_id = aws_subnet.main-public.id
  
  private_ip = var.jump_box_private_ip
  tags = {
    Name = "Jump Box"
  }
}

output "jump_box_public_ip" {
  value = aws_instance.jump_box.public_ip
}

#########################################################
######  Private Box A (for Jump Box connection)  ########
#########################################################

/*
Box A will use the same key as the jump box. In order to facilitate the 
connection from your local machine to the jump box to box A, we need a 
way for the jump box to authenticate. It would be suboptimal to 
put the private key on the jump box. Instead, we can use SSH agent forwarding 
to facilitate connection. On your local machine, you can run: 

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/netsec_jump_box_key

to start the SSH and load the private key into memory. 

Then we can connect to the jump box with: 

ssh -A -i ~/.ssh/netsec_jump_box_key ubuntu@<jump-box-public-ip>

to connect to the jump box with agent forwarding so we can securely 
authenticate to the private subnet as well. 
*/

resource "aws_instance" "box_a" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.jump_box_key.key_name
  vpc_security_group_ids = [aws_security_group.SG_Private_A.id]
  subnet_id = aws_subnet.main-private.id
  private_ip = var.box_a_private_ip


  tags = {
    Name = "Box A"
  }
}


#########################################################
##################  Private Box B  ######################
#########################################################

resource "aws_instance" "box_b" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.SG_Private_B.id]
  subnet_id = aws_subnet.main-private.id
  private_ip = var.box_b_private_ip

  user_data = <<-EOF
  #!/bin/bash
  apt update
  apt install -y python3

  mkdir -p /home/ubuntu/www
  echo "<h1>Hello from EC2-B</h1>" > /home/ubuntu/www/index.html

  cd /home/ubuntu/www
  nohup python3 -m http.server 8000 --bind 0.0.0.0 > /var/log/http.log 2>&1 &
EOF



  tags = {
    Name = "Box B"
  }
}