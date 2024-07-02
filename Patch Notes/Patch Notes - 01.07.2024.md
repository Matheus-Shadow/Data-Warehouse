# Patch Notes - Versão 1.0.0 - 01/07/2024

## Introdução
Esta atualização inclui correções de bugs críticos, melhorias de performance e novas funcionalidades.

## Novas Funcionalidades
- Adicionado suporte para novos formatos de dados.
- Implementada interface de usuário para configuração de ETL.

## Melhorias
- Melhorada a performance de consultas SQL.
- Interface de usuário aprimorada para melhor usabilidade.

## Correções de Bugs
- Corrigido bug que causava falha na importação de dados CSV.
- Resolvido problema de sincronização de dados com fontes externas.

## Problemas Conhecidos
- O problema de latência em grandes volumes de dados ainda está sob investigação.
- A funcionalidade de backup automático pode falhar em algumas condições específicas.

## Alteração na documentação
- Governança: Não sofreu alteração.
- Catálogo: Não sofreu alteração.
- Dicionário: Não sofreu alteração.
- Metadados: Possui as seguintes mudanças, sendo:

- Metadados - Acionamentos do CRM
   - Anteriormente:
  
  | ID_SUB_AC	- BIGINT | 
  | Código do sub acionamento cadastrado - BIGINT |

   - Agora:
  
  | ID_SUB_AC	- INT | 
  | Código do sub acionamento cadastrado - INT |

