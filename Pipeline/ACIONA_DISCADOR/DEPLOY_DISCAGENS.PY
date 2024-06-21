import pandas as pd
import logging
import os
import sys


sys.path.insert(1, r'C:\Users\int.matheus\Desktop\DW\Data-Warehouse\Func')
from utils import connect_to_database, execute_query, main, load_dotenv


if __name__ == "__main__":
    # Defina o caminho para o primeiro arquivo .env e o primeiro arquivo SQL
    env_file_path_1 = r'C:\Users\int.matheus\Desktop\DW\Data-Warehouse\Environment\.Env_07'
    query_file_path_1 = r'C:\Users\int.matheus\Desktop\DW\Data-Warehouse\Source\ACTYON\ACIONA_CRM\ACIONA_CRM.SQL'
    
    # Carregar variáveis de ambiente do .env
    load_dotenv(env_file_path_1)
    
    # Verificar se todas as variáveis de ambiente necessárias foram carregadas
    required_vars = ['SERVER_MIS', 'DATABASE_MIS', 'USERNAME_MIS', 'PASSWORD_MIS', 'DRIVER_MIS', 'PORT_MIS']
    if all([os.getenv(var) for var in required_vars]):
        # Conectar ao banco de dados usando as variáveis do .env
        conn, cursor = connect_to_database({
            'SERVER': os.getenv('SERVER_MIS'),
            'DATABASE': os.getenv('DATABASE_MIS'),
            'USERNAME': os.getenv('USERNAME_MIS'),
            'PASSWORD': os.getenv('PASSWORD_MIS'),
            'DRIVER': os.getenv('DRIVER_MIS'),
            'PORT': os.getenv('PORT_MIS')
        })
        
        if conn and cursor:
            try:
                # Executar a consulta SQL e obter o DataFrame
                df1 = execute_query(cursor, query_file_path_1)
                
                # Desconectar do banco de dados
                conn.close()
                
            except Exception as e:
                logging.error(f"Erro ao executar a consulta SQL: {str(e)}")
                df1 = pd.DataFrame()  # Gerar DataFrame vazio em caso de erro na consulta
        else:
            # Se não foi possível conectar ao banco de dados, gerar DataFrame vazio
            df1 = pd.DataFrame()
    else:
        # Se não foi possível carregar todas as variáveis de ambiente do .env, gerar DataFrame vazio
        df1 = pd.DataFrame()
    
    # Continuar com o processamento do DataFrame df1 conforme necessário
    # Exemplo: salvar df1 em um arquivo, realizar análises, etc.
    logging.info(f"DataFrame df1 criado com {len(df1)} linhas.")