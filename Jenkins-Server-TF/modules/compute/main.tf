data "aws_ami" "ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.ami.image_id
  instance_type          = "m7i-flex.large"
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile   = var.instance_profile_name
  root_block_device {
    volume_size = 30
  }
  
  # Cập nhật đường dẫn file script để phù hợp với thư mục module
  user_data_base64 = base64encode(templatefile("${path.module}/tools-install.sh", {}))

  tags = {
    Name = var.instance_name
  }
}