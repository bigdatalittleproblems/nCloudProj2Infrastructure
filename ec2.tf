resource "aws_key_pair" "deployer" {
  key_name   = "cr-deployer-key"
  public_key = var.deployerkey
}

resource "aws_instance" "crdeployerserver" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.crdeployerserver_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.crdeployerserver_profile.name
  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = 20
    volume_type = "standard"
  }
  tags = {
    Name = "cr-deploymentserver"
  }
  user_data = <<EOF
#!/bin/bash 
yum update -y 
EOF

}
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}
resource "aws_iam_instance_profile" "crdeployerserver_profile" {
  name = "crdeployerserver_profile"
  role = aws_iam_role.ec2Roledeployer.name
}