# Data Warehouse Project

## Descrição

Este projeto de Data Warehouse (DW) foi desenvolvido para centralizar e analisar dados de diversas fontes. Utiliza o Python para ETL (Extract, Transform, Load) e orquestração de toda a pipeline.

## Estrutura do Projeto

- [Documentos](Documentos/): Contém a documentação total do projeto.
  - [Governança.md](Documentos/Governança.md): Documento que descreve os princípios e diretrizes de governança de dados do DW.
  - [Catalogo.md](Documentos/Catalogo.md): Documento que lista e descreve todas as tabelas e conjuntos de dados disponíveis no DW.
  - [Dicionario.md](Documentos/Dicionario.md): Documento que detalha cada campo das tabelas do DW, incluindo tipos de dados, descrições e restrições.
  - [Metadados.md](Documentos/Metadados.md): Documento que explica os metadados utilizados no DW, incluindo informações sobre origem dos dados, periodicidade de atualização, etc.
- [Environment](Environment/): Contém as variáveis de ambiente para conexão das fontes de dados.
- [Func](Func/): Contém as funções para auxiliar a pipeline de dados.
- [Modelagens](Modelagens/): Contém a modelagem conceitual e física (DER).
- [Pipeline](Pipeline/): Scripts orquestradores das fontes de dados.
- [Schema](Schema/): Estrutura dos objetos do SQL (tabelas).
- [Source](Source/): Fonte de dados.
- [.gitignore](.gitignore): Credenciais ocultadas por motivo de segurança.
- [requerimentos.txt](requerimentos.txt): Bibliotecas utilizadas no projeto.
- [README.md](README.md): Este arquivo.

## Pré-requisitos

Certifique-se de ter os seguintes programas instalados:

- Python 3.12.1
- ODBC Driver 17 for SQL Server
- Vscode ou alguma IDE de sua preferência

## Configuração do Ambiente

### Instalando Dependências

Instale as dependências Python necessárias:

```bash
pip install -r requerimentos.txt
