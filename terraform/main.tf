terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "estacao_clima" {
  bucket = "estacao-meteorologica-ingrid-v2-2026"

  tags = {
    Name        = "Armazenamento DevOps"
    Environment = "producao"
    Project     = "Estacao Meteorologica"
  }
}

# Versionamento (recuperação de dados)
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.estacao_clima.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Criptografia (segurança)
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.estacao_clima.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Bloqueio de acesso público
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.estacao_clima.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "nome_do_bucket_criado" {
  description = "Nome do bucket S3 provisionado"
  value       = aws_s3_bucket.estacao_clima.bucket
}