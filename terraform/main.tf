provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "estacao_clima" {
  bucket = "estacao-meteorologica-ingrid-v2-2026" # Mude se quiser

  tags = {
    Name        = "Armazenamento DevOps"
    Environment = "Estudos"
  }
}