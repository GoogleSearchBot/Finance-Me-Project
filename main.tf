provider "aws" {
  region = "ap-south-1"
  access_key = "AKIAWYYXEWHSQTMNMZHE"
  secret_key = "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"
}


resource "aws_security_group" "mysg" {
  name_prefix = "finance-me-sg"
  vpc_id      = "vpc-037232b62dfa10afc"
  description = "Example security group"
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "example-security-group"
  }
}

resource "aws_key_pair" "mykeypair" {
  key_name   = "my-key-pair"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "FinanceMeDeploy" {
  ami           = "ami-02eb7a4783e7e9317"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykeypair.key_name
  vpc_security_group_ids = [aws_security_group.mysg.id]
  tags = {
    Name = "FinanceMEDeploy"
  }

connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key =  file("~/.ssh/id_rsa")
    host        = aws_instance.FinanceMeDeploy.public_ip
  }
 
  provisioner "local-exec" {
    command = "ansible-playbook -i '${aws_instance.FinanceMeDeploy.public_ip},' Ubuntu-config.yml"
  }
  output "public_ip" {
  value = aws_instance.example.public_ip
  }
}
