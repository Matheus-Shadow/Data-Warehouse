import requests, sys ,logging ,os
sys.path.insert(1, 'helpers')
from helpers_ import bot_DW , send_message_topic
from dotenv import load_dotenv
import pyodbc


topico ='5'


if False :

    token , chat = bot_DW()

    send_message_topic(token=token, chat_id=chat, message='Teste', topico=topico)

def load_env(env_file):
    """
    Carrega variáveis de ambiente do arquivo .env especificado.
    
    Args:
    env_file (str): Caminho para o arquivo .env.
    
    Returns:
    dict: Dicionário contendo as variáveis de ambiente carregadas.
    """
    try:
        load_dotenv(env_file)
        env_vars = {
            'SERVER': os.getenv('SERVER_MIS'),
            'DATABASE': os.getenv('DATABASE_MIS'),
            'USERNAME': os.getenv('USERNAME_MIS'),
            'PASSWORD': os.getenv('PASSWORD_MIS'),
            'DRIVER': os.getenv('DRIVER_MIS'),
            'PORT': os.getenv('PORT_MIS')
        }
        
        # Logar as variáveis carregadas
        logging.info(f"Variáveis de ambiente carregadas: {env_vars}")
        
        return env_vars
    except Exception as e:
        logging.error(f"Erro ao carregar o arquivo .env: {str(e)}")
        return None

env_loads = load_env(r'\\10.10.228.100\mis_dados\04 - PROJETOS\DW\Data-Warehouse\Environment\.Env_01')
print(env_loads)

def connect_to_database(env_vars):
    """
    Estabelece uma conexão com o banco de dados utilizando as variáveis de ambiente fornecidas.

    Args:
    env_vars (dict): Dicionário contendo as variáveis de ambiente necessárias para a conexão.

    Returns:
    pyodbc.Connection: Objeto de conexão com o banco de dados.
    """
    try:
        # Verificar se todas as variáveis de ambiente necessárias foram carregadas
        if not all(env_vars.values()):
            raise ValueError("Certifique-se de que todas as variáveis de ambiente necessárias estejam definidas no arquivo .env.")

        # Construir a string de conexão
        connection_string = f"DRIVER={env_vars['DRIVER']};SERVER={env_vars['SERVER']},{env_vars['PORT']};DATABASE={env_vars['DATABASE']};UID={env_vars['USERNAME']};PWD={env_vars['PASSWORD']}"

        # Conectar ao banco de dados
        conn = pyodbc.connect(connection_string)

        logging.info("Conexão ao banco de dados estabelecida.")

        return conn

    except Exception as e:
        logging.error(f"Erro ao conectar ao banco de dados: {str(e)}")
        return None

# Conectar ao banco de dados
connection = connect_to_database(env_loads)

if connection:
    print("Conexão estabelecida com sucesso.")
else:
    print("Falha ao estabelecer conexão.")