import pandas as pd
import logging
import os
import sys
from dotenv import load_dotenv

sys.path.insert(1, r'C:\Users\int.matheus\Desktop\DW\Data-Warehouse\Func')
from utils2 import clear_env_variables, load_env, connect_to_database, execute_query_sql

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def process_query(env_file_path, query_file_path):
    # Limpar variáveis de ambiente anteriores, se houver
    clear_env_variables()
    
    # Carregar variáveis de ambiente do .env
    env_vars = load_env(env_file_path)
    
    # Verificar se todas as variáveis de ambiente necessárias foram carregadas
    required_vars = ['SERVER', 'DATABASE', 'USERNAME', 'PASSWORD', 'DRIVER', 'PORT']
    if all([env_vars.get(var) for var in required_vars]):
        # Conectar ao banco de dados usando as variáveis do .env
        conn = connect_to_database(env_vars)
        
        if conn:
            try:
                # Executar a consulta SQL e obter o DataFrame
                df = execute_query_sql(conn, query_file_path)
                
                # Desconectar do banco de dados
                conn.close()
                
                logging.info(f"DataFrame criado com {len(df)} linhas.")
                return df
            
            except Exception as e:
                logging.error(f"Erro ao executar a consulta SQL: {str(e)}")
                return pd.DataFrame()  # Gerar DataFrame vazio em caso de erro na consulta
        else:
            logging.error("Falha na conexão ao banco de dados.")
            return pd.DataFrame()  # Gerar DataFrame vazio se a conexão falhar
    else:
        logging.error("Erro: Não foi possível carregar todas as variáveis de ambiente necessárias.")
        return pd.DataFrame()  # Gerar DataFrame vazio se as variáveis de ambiente não forem carregadas corretamente

# TAKS_01
env_file_path_Task_01 = r'C:\Users\int.matheus\Desktop\DW\Data-Warehouse\Environment\.Env_07'
query_file_path_Task_01 = r'C:\Users\int.matheus\Desktop\DW\Data-Warehouse\Source\ACTYON\ACIONA_CRM\ACIONA_CRM.SQL'

# Processar a TAKS_01
df_task_01 = process_query(env_file_path_Task_01, query_file_path_Task_01)

# TAKS_02
env_file_path_Task_02 = r'C:\Users\int.matheus\Desktop\DW\Data-Warehouse\Environment\.Env_08'
query_file_path_Task_02 = r'C:\Users\int.matheus\Desktop\DW\Data-Warehouse\Source\ACTYON\ACIONA_CRM\ACIONA_CRM.SQL'

# Processar a TAKS_02
df_task_02 = process_query(env_file_path_Task_02, query_file_path_Task_02)

# TAKS_03
env_file_path_Task_03 = r'C:\Users\int.matheus\Desktop\DW\Data-Warehouse\Environment\.Env_09'
query_file_path_Task_03 = r'C:\Users\int.matheus\Desktop\DW\Data-Warehouse\Source\ACTYON\ACIONA_CRM\ACIONA_CRM.SQL'

# Processar a TAKS_03
df_task_03 = process_query(env_file_path_Task_03, query_file_path_Task_03)

# TAKS_04
env_file_path_Task_04 = r'C:\Users\int.matheus\Desktop\DW\Data-Warehouse\Environment\.Env_10'
query_file_path_Task_04 = r'C:\Users\int.matheus\Desktop\DW\Data-Warehouse\Source\ACTYON\ACIONA_CRM\ACIONA_CRM.SQL'

# Processar a TAKS_04
df_task_04 = process_query(env_file_path_Task_04, query_file_path_Task_04)


# Combinar os DataFrames
combined_df = pd.concat([df_task_01, df_task_02,df_task_03,df_task_04], ignore_index=True)

# Exibir o DataFrame combinado
logging.info(f"DataFrame combinado criado com {len(combined_df)} linhas.")
print(combined_df)

