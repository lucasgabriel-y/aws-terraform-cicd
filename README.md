# Pipeline de CI/CD com Backend S3 para Terraform

Este projeto utiliza um backend S3 para armazenar o arquivo de tfstate do Terraform. 

## Visão Geral

Neste projeto, foi implementado um pipeline de Integração Contínua/Entrega Contínua (CI/CD) que automatiza a implantação de recursos de infraestrutura na AWS usando o Terraform contendo 3 workflows que executam as atividades de formatação, validação, init, apply e destroy sendo esses 3 últimos executados com "workflow_dispatch".

## Caracteristicas

- Implementação automatizada de recursos de infraestrutura com Terraform.
- Armazenamento seguro do arquivo tfstate em um bucket S3.
- Coordenação colaborativa de alterações de infraestrutura.

## Requisitos

Antes de começar, certifique-se de que tenha os seguintes requisitos instalados e configurados:

- Terraform: [Instalação](https://www.terraform.io/downloads.html)
- AWS CLI: [Instalação](https://aws.amazon.com/cli/)
