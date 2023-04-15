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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCuq5Jx7Qeqa3mXGKFO5BjyT80XVQ+fpC3hb+9Fdy7X/SpjOTE2XqVXbAveCb6k4Vq2odeBrPMN/d20ZNWp2xUewz+b3l2DY1HTb1ArA36hR7cadz76si1I2f39XBL514mA0RvOBZRkzLj8LwxobwpwUkEq+XLvbI0oMQ7nzPDwHFGtYzpW72U0r6fyP9wCmdZEZ3ooej3WmDlA7tiQKiPVCWtJqCrX90yC2U3Bm5lesgtY9v7ubOZL6sktGbEBdTF6KYS0KH4vF8lrN+2F1zGp0F2XoJEBD9WSri+OZOo9a4Vax7RqfXCCVZNG0QLxMH9mjDC9r/wzqLZ51FRNIKscxoCKV+FiFsTkQGIpxcWfEs+l68wCtiHF8h6DKxv/T5P00H8lURQhwel4ntVBy2IXnAGVa9QonI8Q56lJlVRoblZVwOrXUsyznVFge9u7H47zI+ZZnMJH05nCiJiRr2PLsIDukPZ8Kdn44m/BWuIutdvR8NvTD/JJMeynRupbxus= kusha@Kushal"
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
    private_key =  <<-EOF
  -----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
 EOF
    host        = aws_instance.FinanceMeDeploy.public_ip
  }
 
  provisioner "local-exec" {
    command = "ansible-playbook -i '${aws_instance.FinanceMeDeploy.public_ip},' Ubuntu-config.yml"
  }
  output "public_ip" {
  value = aws_instance.example.public_ip
  }
}
