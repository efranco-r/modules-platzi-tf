provider "aws" {
	region="us-east-1"
}

resource "aws_security_group" "ssh_conection" {
  name        = var.sg_name
  /*
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "-1"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  }
  */
  dynamic "ingress" {
  	for_each = var.ingress_rules
  	content {
  		from_port        = ingress.value.from_port
    	to_port          = ingress.value.to_port
    	protocol         = ingress.value.protocol
    	cidr_blocks      = ingress.value.cidr_blocks
  	}
  }
  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      cidr_blocks      = egress.value.cidr_blocks
    }
  }
}

resource "aws_instance" "platzi-instance"{
	ami = var.ami_id
	instance_type = var.instance_type
	tags = var.tags
	security_groups = [aws_security_group.ssh_conection.name]
  user_data = file("userdata.yaml") #Este archivo hace la magia

  /*
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "root"
      private_key = "${file("~/.ssh/packer-key")}"
      host = self.public_ip
    }
    inline = ["echo hello", "docker -run -it -d -p 3003:80 efrancor/hello-platzi:v1"]
  }
  */
}