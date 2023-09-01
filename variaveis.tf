variable "region" {
  type        = string
  description = "Regiao"
  default     = "us-east-1"

}

variable "ami" {
  type        = string
  description = "Image"
  default     = "ami-053b0d53c279acc90"
}

variable "nome-ami" {
  type        = string
  description = "AMI gerada pelo recurso aws_ami "
  default     = "ami-app-db"
}


variable "descricao-ami" {
  type        = string
  description = "AMI criada a partir da EC2"
  default     = "AMI criada a partir da EC2"
}

variable "root-device-ami" {
  type        = string
  description = "Disco raiz da AMI"
  default     = "/dev/sda1"
}

variable "tipo-virtualizacao" {
  type        = string
  description = "Tipo de virtualizacao"
  default     = "hvm"
}

variable "instance_type" {
  type        = string
  description = "Tamanho instancia"
  default     = "t2.micro"

}


variable "lb_type" {
  type        = string
  description = "Tipo de load b"
  default     = "application"

}

variable "sns_endpoint" {
  type        = string
  description = "Email SNS"
  default     = "gabriel.lglg93@gmail.com"

}

variable "user_ssh" {
  type        = string
  description = "Usuario SSH"
  default     = "ubuntu"

}

variable "nome_instancia" {
  type        = string
  description = "Nome da instancia"
  default     = "terraform-app"

}