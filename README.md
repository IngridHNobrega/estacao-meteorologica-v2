# Projeto: Estação Meteorológica Digital

# 1. Introdução

O projeto **Estação Meteorológica Digital** tem como finalidade o desenvolvimento automatizado de uma infraestrutura em nuvem destinada ao armazenamento de dados climáticos provenientes de uma estação meteorológica.

A proposta fundamenta-se nos princípios de **DevOps**, com ênfase em:

* Infraestrutura como Código (Infrastructure as Code – IaC);
* Integração Contínua (Continuous Integration – CI);
* Entrega Contínua (Continuous Delivery – CD);
* Automação de processos;
* Redução de erros humanos no provisionamento e manutenção da infraestrutura.

O projeto foi estruturado em fases evolutivas, ampliando progressivamente o nível de maturidade do ciclo de vida de desenvolvimento de software (SDLC).

# Fase 1 – Automação de Infraestrutura e Integração Contínua

# 2. Objetivos da Fase 1

A primeira fase teve como foco principal:

* Eliminar o provisionamento manual da infraestrutura em nuvem;
* Garantir rastreabilidade e versionamento da infraestrutura;
* Assegurar que toda modificação no código seja automaticamente validada;
* Reduzir falhas decorrentes de erros de configuração.

O requisito central estabelecido foi que **nenhuma alteração no repositório principal poderia ocorrer sem validação automatizada prévia**.

# 3. Especificação da Infraestrutura

A infraestrutura foi implementada utilizando a plataforma **Amazon Web Services (AWS)**.

# 3.1 Recurso Provisionado

* **Serviço:** Amazon S3 (Simple Storage Service)
* **Região:** `us-east-1`
* **Finalidade:** Armazenamento de logs climáticos em formato bruto

O Amazon S3 foi selecionado devido às seguintes características:

* Alta durabilidade dos dados;
* Alta disponibilidade;
* Escalabilidade automática;
* Baixa complexidade operacional.

##4. Infraestrutura como Código (IaC)

O provisionamento da infraestrutura foi realizado por meio do **HashiCorp Terraform**, adotando abordagem declarativa.

# 4.1 Organização do Código

* Diretório: `/terraform`
* Arquivos principais:

  * Definição de recursos (`.tf`)
  * Configuração de provider AWS
  * Parametrizações e variáveis

O uso de IaC permite:

* Reprodutibilidade do ambiente;
* Auditoria por meio de versionamento;
* Redução de inconsistências entre ambientes.

# 5. Versionamento e Governança de Código

Todo o código-fonte da aplicação e da infraestrutura foi centralizado no **GitHub**, garantindo:

* Controle de versão distribuído;
* Histórico de alterações;
* Integração com pipelines automatizados.

# 6. Pipeline de Integração Contínua (CI)

O pipeline de CI foi implementado utilizando **GitHub Actions**, com configuração localizada em:

.github/workflows/ci.yml

# 6.1 Gatilho de Execução

O workflow é acionado automaticamente a cada `push` realizado na branch `main`.

# 6.2 Etapas do Processo de CI

O pipeline executa as seguintes etapas em um ambiente virtual Ubuntu:

1. **Checkout do código-fonte**

   * Extração da versão atual do repositório.

2. **Execução de testes em Python**

   * Validação da lógica de processamento dos dados meteorológicos.
   * Garantia de integridade da manipulação dos arquivos.

3. **Terraform Init**

   * Inicialização do backend e download dos providers necessários.

4. **Terraform Validate**

   * Verificação sintática e semântica dos arquivos de infraestrutura.
   * Prevenção de erros de provisionamento antes do deploy.

Essa abordagem assegura que códigos inválidos não sejam integrados ao ramo principal do projeto.

# Fase 2 – Containerização e Entrega Contínua

# 7. Evolução Arquitetural

Na Fase 2, o projeto foi expandido para incluir:

* Containerização da aplicação;
* Automação do processo de build;
* Preparação para entrega contínua;
* Maior padronização de ambientes.

Essa etapa representa um avanço na maturidade DevOps do projeto.

# 8. Objetivos Técnicos da Fase 2

# 8.1 Portabilidade

Implementar isolamento de dependências por meio de containers Docker, garantindo que a aplicação execute de forma idêntica em qualquer ambiente compatível.

# 8.2 Automação da Entrega

Expandir o pipeline para incluir:

* Build da imagem Docker;
* Versionamento do artefato;
* Simulação de deploy.

# 8.3 Imutabilidade de Ambiente

Assegurar que o ambiente de execução seja:

* Reprodutível;
* Independente do sistema operacional hospedeiro;
* Livre de divergências entre desenvolvimento e produção.

# 9. Arquitetura em Camadas

A solução foi estruturada em camadas técnicas bem definidas:

# 9.1 Camada de Aplicação (Runtime)

* Linguagem: Python 3.9-slim
* Script principal: `validar_dados.py`
* Responsabilidade:

  * Processamento de ingestão;
  * Validação de logs climáticos;
  * Tratamento de dados estruturados.

# 9.2 Camada de Infraestrutura (IaC)

* Ferramenta: HashiCorp Terraform
* Recurso provisionado: Amazon S3 Bucket
* Região: us-east-1

A validação da infraestrutura ocorre automaticamente no pipeline, reduzindo riscos de falhas em produção.

# 9.3 Camada de Containerização

* Arquivo: `Dockerfile`
* Estratégia: Construção de imagem multicamada

Benefícios:

* Isolamento de dependências;
* Redução de conflitos de bibliotecas;
* Portabilidade entre ambientes;
* Padronização do runtime.

# 9.4 Camada de Automação (CI/CD)

Orquestrada via GitHub Actions, a esteira de automação foi organizada em dois grandes blocos:

# 10. Pipeline de CI/CD

# 10.1 Job: Integração Contínua (CI)

Etapas executadas:

1. Checkout do código
2. Execução de testes em Python
3. Terraform Init
4. Terraform Validate

Objetivo: Garantir integridade lógica e estrutural antes da geração de artefatos.

# 10.2 Job: Entrega Contínua (CD)

Etapas executadas:

1. **Build**

   * Construção da imagem Docker com base no contexto do repositório.

2. **Tagging**

   * Aplicação de metadados de versionamento à imagem.

3. **Simulação de Deploy**

   * Verificação da integridade do artefato.
   * Preparação para envio a um Container Registry.

Essa estrutura permite futura integração com ambientes produtivos reais.

# 11. Segurança e Governança

# 11.1 Gestão de Segredos

Credenciais sensíveis, como chaves de acesso à AWS, são armazenadas utilizando **GitHub Secrets**, evitando exposição no código-fonte.

# 11.2 Imutabilidade

A utilização de containers reduz o risco de *configuration drift*, assegurando que o ambiente de produção corresponda exatamente ao ambiente testado.

# 11.3 Validações Automatizadas

A aplicação de testes e validações sintáticas impede que código instável seja integrado ao repositório principal.

# 12. Monitoramento e Escalabilidade (Perspectivas Futuras)

Como evolução natural do projeto, propõe-se:

* Integração com serviços de monitoramento e logs estruturados (ex.: AWS CloudWatch);
* Implementação de orquestração de containers via Kubernetes (Amazon EKS);
* Escalabilidade horizontal conforme aumento do volume de dados processados.

Essas melhorias permitirão maior robustez operacional e adaptação a cenários de crescimento.

# Conclusão

O projeto Estação Meteorológica Digital demonstra, de forma prática e incremental, a aplicação dos principais fundamentos de DevOps:

* Automação de infraestrutura;
* Validação contínua de código;
* Padronização de ambientes;
* Entrega automatizada de artefatos.

A abordagem adotada reduz riscos operacionais, aumenta a confiabilidade do sistema e estabelece uma base sólida para evolução arquitetural futura.
