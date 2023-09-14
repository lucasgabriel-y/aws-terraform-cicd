terraform {
  
  backend "s3" {
    bucket = "bucketerraform-lg"
    key    = "terraform\terraform.tfstate"
    region = "us-east-1"
  }
}

# Define o provedor AWS e suas credenciais
provider "aws" {
  region = "us-east-1"  # Altere para a região desejada
}

# Cria uma instância EC2
resource "aws_instance" "example" {
  ami           = "ami-051f7e7f6c2f40dc1" 
  instance_type = "t2.micro"              # Tipo de instância
}

# Exemplo de saída que exibirá o endereço IP público da instância criada
output "public_ip" {
  value = aws_instance.example.public_ip
}