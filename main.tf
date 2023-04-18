provider "aws" {
  region = "ap-south-1"
  access_key = "AKIAWYYXEWHS6BU6OHXN"
  secret_key = "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"
}


resource "aws_security_group" "mysg" {
  name_prefix = "finance-me-sg"
  vpc_id      = "vpc-037232b62dfa10afc"
  description = "Example security group"
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "FinanceMe-SG"
  }
}

resource "aws_instance" "FinanceMeDeploy" {
  ami           = "ami-02eb7a4783e7e9317"
  instance_type = "t2.micro"
  key_name = "Kushal"
  vpc_security_group_ids = [aws_security_group.mysg.id]
  tags = {
    Name = "FinanceMEDeploy"
  }
  provisioner "remote-exec" {
  inline = [ "echo wait till ssh connection is ready"]
	  
   connection {
     type        = "ssh"
     user        = "ubuntu"
     private_key = file("Kushal.pem")
     host        = self.public_ip
   }
  }
  provisioner "local-exec" {
        command = " echo ${aws_instance.FinanceMeDeploy.public_ip} >> inventory.txt "
  }

   provisioner "local-exec" {
	   command = " ansible-playbook /var/lib/jenkins/workspace/FinanceMe/Finance-Playbook.yml "
 }
}
output "finance-me-ip" {
	value = aws_instance.FinanceMeDeploy.public_ip
}
