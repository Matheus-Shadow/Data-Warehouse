import requests
import pandas as pd
import numpy as np
import pyodbc
import psycopg2
from datetime import datetime
from dotenv import load_dotenv
import os
import logging


# Configurar o logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')



def connect_to_database(env_file):
    """
    Carrega variáveis de ambiente de um arquivo .env especificado e estabelece uma conexão com o banco de dados.
    
    Args:
    env_file (str): Caminho para o arquivo .env.
    
    Returns:
    connection: Objeto de conexão com o banco de dados.
    cursor: Objeto cursor para interagir com o banco de dados.
    """
    # Carregar variáveis de ambiente do arquivo .env especificado
    load_dotenv(env_file)
    
    # Parâmetros da conexão
    SERVER = os.getenv('SERVER_MIS')
    DATABASE = os.getenv('DATABASE_MIS')
    USERNAME = os.getenv('USERNAME_MIS')
    PASSWORD = os.getenv('PASSWORD_MIS')
    DRIVER = os.getenv('DRIVER_MIS')
    PORT = os.getenv('PORT_MIS') 
    
    # Logar as variáveis carregadas
    logging.info(f"Servidor: {SERVER}")
    logging.info(f"Banco de Dados: {DATABASE}")
    logging.info(f"Usuário: {USERNAME}")


    # Verificar se todas as variáveis de ambiente necessárias foram carregadas
    if not all([SERVER, DATABASE, USERNAME, PASSWORD, DRIVER]):
        raise ValueError("Certifique-se de que todas as variáveis de ambiente (SERVER_MIS, DATABASE_MIS, USERNAME_MIS, PASSWORD_MIS, DRIVER_MIS) estejam definidas no arquivo .env.")
    
    # Conexão com o SQL Server
    connection_string = f'DRIVER={DRIVER};SERVER={SERVER},{PORT};DATABASE={DATABASE};UID={USERNAME};PWD={PASSWORD}'
    connection = pyodbc.connect(connection_string)
    cursor = connection.cursor()
    
    return connection, cursor

"""
Exemplo de uso:

env_file_path = 'path/to/your/.env'  # Substitua pelo caminho para o seu arquivo .env

connection, cursor = connect_to_database(env_file_path)

Agora você pode usar 'connection' e 'cursor' para interagir com o banco de dados
"""


# Carrega as variáveis de ambiente do arquivo .env
#load_dotenv(dotenv_path=r"C:\Users\Matheus Alexander\Desktop\DW\Data-Warehouse\Environment\.env")
# Exemplo de uso
if __name__ == "__main__":
    env_file_path = r'C:\Users\int.matheus\Desktop\DW\Data-Warehouse\Environment\.Env_01'  # Substitua pelo caminho para o seu arquivo .env
    connection, cursor = connect_to_database(env_file_path)
    logging.info("Conexão estabelecida com sucesso.")



    data = cursor.execute("SELECT TOP 10 *  FROM users")


    # Obter os dados
columns = [column[0] for column in cursor.description]  # Obter nomes das colunas
data = cursor.fetchall()  # Obter todas as linhas

# Converter os dados para uma lista de dicionários
result = [dict(zip(columns, row)) for row in data]

# Opcional: Converter os dados para um DataFrame do Pandas
df = pd.DataFrame(result)

# Fechar a conexão
cursor.close()
connection.close()