import pandas as pd
import logging
import os
import sys
from dotenv import load_dotenv

sys.path.insert(1, r'C:\Users\int.matheus\Desktop\DW\Data-Warehouse\Func')
from utils2 import clear_env_variables, load_env, connect_to_database, execute_query_sql

if __name__ == "__main__":
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

    # Defina os caminhos para os arquivos .env e SQL
    env_file_paths = [
        r'C:\Users\int.matheus\Desktop\DW\Data-Warehouse\Environment\.Env_07']
    query_file_path = r'C:\Users\int.matheus\Desktop\DW\Data-Warehouse\Source\ACTYON\ACIONA_CRM\ACIONA_CRM.SQL'

    # Processar cada conjunto de arquivos .env e SQL
    dfs = [process_query(env_file_path, query_file_path) for env_file_path in env_file_paths]

    # Inicialize combined_df como um DataFrame vazio
    combined_df = pd.DataFrame()

    # Iterar sobre a lista de DataFrames e concatená-los
    for df in dfs:
        if not df.empty:
            if combined_df.empty:
                combined_df = df  # Se combined_df estiver vazio, defina-o como o primeiro DataFrame não vazio
            else:
                combined_df = pd.concat([combined_df, df], ignore_index=True)  # Concatene com o DataFrame existente

    # Exibir o DataFrame combinado
    logging.info(f"DataFrame combinado criado com {len(combined_df)} linhas.")
    # print(combined_df)  # Descomente para exibir o DataFrame combinado
