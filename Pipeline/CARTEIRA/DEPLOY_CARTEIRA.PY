import os
from datetime import datetime

import numpy as np
import pandas as pd
import psycopg2
import pyodbc
import requests
from dotenv import load_dotenv

dotenv_path = '/Environment/.Env'

# Carregue as variáveis de ambiente do arquivo .env
load_dotenv()

# Acesse as variáveis de ambiente
server = os.getenv('SERVER_MIS')
database = os.getenv('DATABASE_MIS')
username = os.getenv('USERNAME_MIS')
password = os.getenv('PASSWORD_MIS')

# Exemplo de uso das variáveis
print(f"Conectando ao servidor {server}...")
print(f"Acessando o banco de dados {database} com o usuário {username}...")
# Você não deve imprimir a senha em produção, isso é apenas um exemplo.
print(f"Senha do usuário: {password}")
