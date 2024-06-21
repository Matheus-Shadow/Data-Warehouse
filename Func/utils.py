import os
import pyodbc
import pandas as pd
from dotenv import load_dotenv
import logging

# Configurar o logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def clear_env_variables():
    """
    Limpa as variáveis de ambiente específicas usadas para conexão ao banco de dados.
    """
    keys_to_clear = ['SERVER_MIS', 'DATABASE_MIS', 'USERNAME_MIS', 'PASSWORD_MIS', 'DRIVER_MIS', 'PORT_MIS']
    for key in keys_to_clear:
        if key in os.environ:
            del os.environ[key]

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

def execute_query_sql(conn, query_file):
    try:
        with open(query_file, 'r') as file:
            query = file.read()

        # Usar read_sql_query para executar a consulta
        df = pd.read_sql_query(query, conn)

        logging.info("Consulta SQL executada com sucesso.")

        return df

    except Exception as e:
        logging.error(f"Erro ao executar a consulta SQL: {str(e)}")
        return pd.DataFrame() 

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
        connection_string = f"DRIVER={{{env_vars['DRIVER']}}};SERVER={env_vars['SERVER']},{env_vars['PORT']};DATABASE={env_vars['DATABASE']};UID={env_vars['USERNAME']};PWD={env_vars['PASSWORD']}"

        # Conectar ao banco de dados
        conn = pyodbc.connect(connection_string)

        logging.info("Conexão ao banco de dados estabelecida.")

        return conn

    except Exception as e:
        logging.error(f"Erro ao conectar ao banco de dados: {str(e)}")
        return None

def main(env_file, query_file):
    """
    Função principal para conectar ao banco, executar a consulta e salvar o resultado.
    
    Args:
    env_file (str): Caminho para o arquivo .env.
    query_file (str): Caminho para o arquivo SQL contendo a consulta.
    
    Returns:
    DataFrame: DataFrame contendo os resultados da consulta.
    """
    try:
        # Carregar variáveis de ambiente
        env_vars = load_env(env_file)
        
        if env_vars:
            # Conectar ao banco de dados
            conn, cursor = connect_to_database(env_vars)
            
            if conn and cursor:
                # Executar a consulta e obter o DataFrame
                df = execute_query(cursor, query_file)
                
                # Fechar conexão com o banco de dados
                cursor.close()
                conn.close()
                
                logging.info("Conexão fechada com sucesso.")
            else:
                # Se não foi possível conectar ao banco de dados, gerar DataFrame vazio
                df = pd.DataFrame()
        else:
            # Se não foi possível carregar as variáveis de ambiente do .env, gerar DataFrame vazio
            df = pd.DataFrame()
        
        return df
    except Exception as e:
        logging.error(f"Erro durante a execução: {str(e)}")
        return pd.DataFrame()  # Retorna um DataFrame vazio em caso de erro

