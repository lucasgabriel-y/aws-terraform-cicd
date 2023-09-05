terraform {
  
  backend "s3" {
    bucket = "bucketerraform-lg"
    key    = "terraform\terraform.tfstate"
    region = "us-east-2"
    profile = "default"
  }
}


provider "aws" {
  region = var.region
  profile = "default"
}


#Cria o recurso para usar uma chave de acesso  
resource "aws_key_pair" "key-pair" {
  key_name   = "tf-app"
  public_key = file("/id_rsa.pub")

}

#Cria a instancia EC2
resource "aws_instance" "terraform" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.private_subnet.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = false
  key_name                    = aws_key_pair.key-pair.key_name #Associa a chave de acesso a instancia

  tags = {
    Name = "${var.nome_instancia}"
  }


}

resource "aws_ebs_snapshot" "ec2_snapshot" {
  volume_id = aws_instance.terraform.root_block_device[0].volume_id
}

#Cria uma AMI com base na EC2 criada anteriormente
resource "aws_ami" "ami_app" {
  name                = var.nome-ami
  description         = var.descricao-ami
  root_device_name    = var.root-device-ami
  virtualization_type = var.tipo-virtualizacao

  ebs_block_device {
    device_name = var.root-device-ami
    snapshot_id = aws_ebs_snapshot.ec2_snapshot.id
    volume_size = 10
    delete_on_termination = true
  }

  tags = {
    Name = var.nome-ami
  }
}
