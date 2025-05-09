resource "aws_instance" "jenkins_server" {
  ami                    = var.ami_id                   # <- must be passed in
  instance_type          = var.instance_type            # <- must be passed in
  key_name               = var.key_name                 # <- must be passed in
  vpc_security_group_ids = [var.security_group_id]      # <- correct if var is a string
  subnet_id              = var.subnet_id                # <- must be passed in
  user_data              = file("${path.module}/jenkins.sh")

  tags = {
    Name = "jenkins-server"
  }
}