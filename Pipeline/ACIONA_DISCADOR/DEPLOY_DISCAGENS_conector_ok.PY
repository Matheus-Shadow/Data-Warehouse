import os
from dotenv import load_dotenv

# Caminho para o arquivo .env
env_file_path = r'C:\Users\int.matheus\Desktop\DW\Data-Warehouse\Environment\.Env_08'

def load_env(env_file):
    """
    Carrega as variáveis de ambiente do arquivo .env especificado.
    
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
        return env_vars
    except Exception as e:
        print(f"Erro ao carregar o arquivo .env: {str(e)}")
        return None

if __name__ == "__main__":
    # Carregar variáveis de ambiente do .env
    env_vars = load_env(env_file_path)
    
    # Verificar se todas as variáveis de ambiente necessárias foram carregadas
    required_vars = ['SERVER_MIS', 'DATABASE_MIS', 'USERNAME_MIS', 'PASSWORD_MIS', 'DRIVER_MIS', 'PORT_MIS']
    if all([os.getenv(var) for var in required_vars]):
        print("Todas as variáveis de ambiente foram carregadas com sucesso.")
        # Aqui você pode continuar com sua lógica de conexão ao banco de dados, execução de consultas, etc.
    else:
        print("Erro: Não foi possível carregar todas as variáveis de ambiente necessárias.")

print(env_vars)