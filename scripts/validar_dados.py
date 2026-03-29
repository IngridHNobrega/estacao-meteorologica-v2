import os

def validar():
    caminho = "dados_clima.txt"
    if not os.path.exists(caminho):
        print("ERRO: Arquivo de dados não encontrado!")
        exit(1)

    with open(caminho, "r") as f:
        dados = f.readlines()
        if len(dados) == 0:
            print("ERRO: O arquivo está vazio!")
            exit(1)

    print(f"Sucesso! {len(dados)} leituras de temperatura validadas.")

if __name__ == "__main__":
    validar()