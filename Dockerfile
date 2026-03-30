FROM python:3.9.19-slim

WORKDIR /app

# Copia os arquivos corretamente
COPY scripts/ ./scripts/
COPY dados_clima.txt .

# Segurança: evitar rodar como root
RUN useradd -m appuser
USER appuser

# Executa o script
CMD ["python", "scripts/validar_dados.py"]