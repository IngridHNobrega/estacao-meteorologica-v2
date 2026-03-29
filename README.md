Projeto: Estação Meteorológica Digital

Descrição do projeto, objetivos e requisitos:

O projeto consiste no desenvolvimento automatizado de uma infraestrutura em nuvem para armazenar dados de uma estação meteorológica. O objetivo é eliminar o provisionamento manual, utilizando práticas de DevOps (IaC e CI/CD) para garantir que a infraestrutura seja escalável, auditável e livre de erros humanos. O requisito principal é manter o ambiente testado a cada alteração no código.

Plano de Integração Contínua:
O fluxo de CI é acionado a cada `push` na branch `main`. O GitHub Actions é responsável por subir um ambiente virtual (Ubuntu), executar os testes de validação dos dados em Python e realizar a validação sintática dos scripts do Terraform, garantindo que nenhum código quebrado vá para produção.

Especificação detalhada da infraestrutura:
Foi utilizada a AWS (Amazon Web Services). O recurso provisionado é um Amazon S3 Bucket localizado na região `us-east-1`. Ele atua como um repositório seguro e de alta disponibilidade para o armazenamento dos logs climáticos em formato bruto.

Configuração de um repositório de código:
Todo o versionamento de código e versionamento de infraestrutura foi centralizado no GitHub.

Implementação de um pipeline de CI usando GitHub Actions:
O arquivo de configuração do pipeline encontra-se em `.github/workflows/ci.yml`.

Scripts para o provisionamento de infraestrutura (Terraform):
A infraestrutura como código foi desenvolvida usando HashiCorp Terraform e encontra-se na pasta `/terraform` do repositório.