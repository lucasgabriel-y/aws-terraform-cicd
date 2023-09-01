#Cria o recurso para usar uma chave de acesso  
resource "aws_key_pair" "key-pair-bastion" {
  key_name   = "key-bastion"
  public_key = file("/id_rsa.pub")

}

#Cria a instancia EC2
resource "aws_instance" "bastion" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet_bastion.id
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.key-pair.key_name #Associa a chave de acesso a instancia

  tags = {
    Name = "bastion-host"
  }

}

#Associa um IP elastico a uma instancia
resource "aws_eip" "eip" {
  instance = aws_instance.bastion.id
}

#Exibe o IP publico associado
output "IP-bastion" {
  value = aws_eip.eip.public_ip

}