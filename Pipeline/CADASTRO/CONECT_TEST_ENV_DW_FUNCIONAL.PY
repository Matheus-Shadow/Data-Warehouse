import os
from datetime import datetime

import numpy as np
import pandas as pd
import psycopg2
import pyodbc
import requests
from dotenv import load_dotenv

dotenv_path = r'Q:\04 - PROJETOS\DW\Data-Warehouse\Environment\.Env_18'

# Carregue as variáveis de ambiente do arquivo .env
load_dotenv(dotenv_path)

# Acesse as variáveis de ambiente
server = os.getenv('SERVER_MIS')
database = os.getenv('DATABASE_MIS')
#username = os.getenv('USERNAME_MIS')
#password = os.getenv('PASSWORD_MIS')
driver = os.getenv('DRIVER_MIS')
port = os.getenv('PORT_MIS')


# Exemplo de uso das variáveis
print(f"Conectando ao servidor {server}...")


# Conectar ao banco de dados usando pyodbc
connection_string = (
    f"DRIVER={driver};"
    f"SERVER={server},{port};"
    f"DATABASE={database};"
    f"Trusted_Connection=yes;"
)

try:
    connection = pyodbc.connect(connection_string)
    print("Conexão bem-sucedida!")

    # Agora você pode usar a conexão para consultas SQL
    query = "SELECT TOP 10 * FROM aciona_crm"  # Exemplo de consulta SQL
    df = pd.read_sql(query, connection)
    print(df.head())

except Exception as e:
    print(f"Erro na conexão: {e}")

finally:
    # Certifique-se de fechar a conexão
    if 'connection' in locals() and connection is not None:
        connection.close()