resource "tls_private_key" "ec2" {
    algorithm="RSA"
    rsa_bits=4096
  
}

resource "aws_key_pair" "ec2" {
  key_name = "${var.key_name}"
  public_key = "${tls_private_key.ec2.public_key_openssh}"
}


resource "aws_instance" "ec2-test" {

    ami                             ="${var.ami_id}"
    instance_type                   ="${var.instance_type}"
    key_name                        ="${aws_key_pair.ec2.id}"
    subnet_id                       ="${var.subnet_id}"
    vpc_security_group_ids           =["${aws_security_group.ec2-sg.id}"]

  


    tags = {
    Name  = "ec2-test"
    key_name      ="${aws_key_pair.ec2.id}"

    }
 
  
}




resource "aws_security_group" "ec2-sg" {
  name          ="ec2-sg"
  description   ="allow all the inbound traffic"
  vpc_id        ="${var.vpc_id}"
  
  lifecycle{
        create_before_destroy=true

    }
}
resource "aws_security_group_rule" "allow_all_ssh" {
    type                ="ingress"
    from_port           = 22
    to_port             = 22
    protocol            ="tcp"
    cidr_blocks         =["0.0.0.0/0"]
    security_group_id   ="${aws_security_group.ec2-sg}"
  
}

resource "aws_security_group_rule" "allow_all_outbound" {
    type                    ="egress"
    from_port               =0
    to_port                 = 0
    protocol                ="-1"
    cidr_blocks             =["0.0.0.0/0"]
    security_group_id       ="${aws_security_group.ec2-sg}"

}