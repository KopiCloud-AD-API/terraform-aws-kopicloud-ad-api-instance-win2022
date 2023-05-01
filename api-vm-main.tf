###################################
## Virtual Machine Module - Main ##
###################################

# Get latest Windows Server 2022 AMI
data "aws_ami" "windows-2022" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base*"]
  }
}

# Define the security group for the API server
resource "aws_security_group" "api-sg" {
  name        = "${lower(var.app_name)}-${var.app_environment}-sg"
  description = "Allow incoming connections"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming HTTPS connections"
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming RDP connections"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-sg"
    Environment = var.app_environment
  }
}

# Bootstrapping PowerShell Script
data "template_file" "api-userdata" {
  template = file("${path.module}/setup-api.ps1")
}

# Create EC2 Instance
resource "aws_instance" "api-server" {
  ami                         = data.aws_ami.windows-2022.id
  instance_type               = var.api_instance_type
  subnet_id                   = aws_subnet.public-subnet.id
  vpc_security_group_ids      = [aws_security_group.api-sg.id]
  associate_public_ip_address = var.api_associate_public_ip_address
  source_dest_check           = false
  key_name                    = aws_key_pair.key_pair.key_name
  user_data                   = data.template_file.api-userdata.rendered
  
  # root disk
  root_block_device {
    volume_size           = var.api_root_volume_size
    volume_type           = var.api_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }

  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-server"
    Environment = var.app_environment
  }
}

# Create Elastic IP for the EC2 instance
resource "aws_eip" "api-eip" {
  vpc  = true
  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-server-eip"
    Environment = var.app_environment
  }
}

# Associate Elastic IP to API Server
resource "aws_eip_association" "api-eip-association" {
  instance_id   = aws_instance.api-server.id
  allocation_id = aws_eip.api-eip.id
}
