# Data Warehouse Project

## Descrição

Este projeto de Data Warehouse (DW) foi desenvolvido para centralizar e analisar dados de diversas fontes. Utiliza o Python para ETL (Extract, Transform, Load) e orquestração de toda a pipeline.

## Estrutura do Projeto

- `Documentos/`: Contém a documentação total do projeto.
- `Environment/`: Contém as variáveis de ambiente para conexão das fontes de dados.
- `Func/`: Contém as funções para auxiliar a pipeline de dados.
- `Modelagens/`: Contém a modelagem conceitural e física (DER).
- `Pipeline/`: Scripts orquestradores das fontes de dados.
- `Schema/` : Estrutura dos objetos do sql (tabelas).
- `Source/` : Fonte de dados.
- `.gitignore` : Credenciais ocultadas por motivo de segurança.
- `requerimentos`: Bibliotecas utilizadas no projeto.
- `README.md`: Este arquivo.

## Pré-requisitos

Certifique-se de ter os seguintes programas instalados:

- Python 3.12.1
- ODBC Driver 17 for SQL Server
- Vscode ou alguma ide de sua preferência

## Configuração do Ambiente

### Instalando Dependências

Instale as dependências Python necessárias:

```bash
pip install -r requerimentos.txt
