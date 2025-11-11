# Banco de Dados - Menu

Este diretório contém os arquivos SQL para configuração do banco de dados do projeto Menu.

## Estrutura de Arquivos

### 📄 schema.sql
Arquivo DDL (Data Definition Language) contendo:
- Criação do banco de dados `menu_db`
- Definição de todas as tabelas (usuario, grupo, grupo_usuario, prato, ingrediente)
- Índices para otimização de consultas
- Função `get_current_timestamp()`
- Triggers para geração automática de UUID
- Triggers para atualização de timestamps
- Views filtradas por tipo e origem
- Roles MySQL (role_mantenedor, role_qualidade)
- Users MySQL (api_user, testador)

### 📄 dados.sql
Arquivo DML (Data Manipulation Language) contendo:
- Inserção dos grupos da aplicação
- Usuário administrador padrão (opcional, comentado)
- Dados de exemplo de pratos com ingredientes

## Como Executar

### Opção 1: Executar em sequência (recomendado)

```bash
# 1. Criar estrutura do banco de dados
mysql -u root -p < schema.sql

# 2. Inserir dados iniciais
mysql -u root -p < dados.sql
```

### Opção 2: Executar tudo de uma vez

```bash
# Executar ambos os arquivos
cat schema.sql dados.sql | mysql -u root -p
```

### Opção 3: Dentro do MySQL

```bash
mysql -u root -p
```

```sql
SOURCE /caminho/completo/para/schema.sql;
SOURCE /caminho/completo/para/dados.sql;
```

## Usuários MySQL Criados

### 🔧 api_user
- **Senha**: `api_senha_123` (deve ser alterada em produção)
- **Role**: role_mantenedor
- **Permissões**: SELECT, INSERT, UPDATE, DELETE em todo o schema menu_db
- **Uso**: Conexão do backend NestJS

**Configuração no backend (.env):**
```env
DB_USERNAME=api_user
DB_PASSWORD=api_senha_123
```

### 🧪 testador
- **Senha**: `testador_senha_123` (deve ser alterada em produção)
- **Role**: role_qualidade
- **Permissões**: SELECT (somente leitura) em todo o schema menu_db
- **Uso**: Testes e QA

**Teste de acesso:**
```bash
mysql -u testador -p menu_db
```

## Grupos da Aplicação

O sistema possui 5 grupos configurados:

1. **administrador** - Acesso completo ao schema da aplicação
2. **nutricionista** - Acesso de escrita e atualização na tabela prato
3. **usuario_comum** - Acesso de leitura às views de pratos filtrados
4. **mantenedor** - Acesso de leitura e escrita a todo o schema menu_db
5. **qualidade** - Acesso somente leitura do schema menu_db

## Verificar Instalação

```sql
-- Verificar tabelas criadas
USE menu_db;
SHOW TABLES;

-- Verificar grupos inseridos
SELECT * FROM grupo;

-- Verificar pratos de exemplo
SELECT * FROM prato;

-- Verificar permissões do api_user
SHOW GRANTS FOR 'api_user'@'%';

-- Verificar permissões do testador
SHOW GRANTS FOR 'testador'@'%';
```

## Estrutura do Banco

```
menu_db
├── Tabelas
│   ├── usuario
│   ├── grupo
│   ├── grupo_usuario
│   ├── prato
│   └── ingrediente
├── Views
│   ├── view_pratos_veganos
│   ├── view_pratos_vegetarianos
│   ├── view_pratos_onivoros
│   ├── view_pratos_brasileiros
│   ├── view_pratos_franceses
│   ├── view_pratos_indianos
│   └── view_pratos_completos
├── Função
│   └── get_current_timestamp()
└── Triggers
    ├── UUID generation (5 triggers)
    └── Timestamp updates (4 triggers)
```

## Observações Importantes

⚠️ **Senhas Padrão**: As senhas dos usuários MySQL devem ser alteradas em produção.

⚠️ **Usuário Admin**: O usuário administrador está comentado no arquivo `dados.sql`. Descomente se desejar criar um usuário admin padrão.

⚠️ **Dados de Exemplo**: Os pratos inseridos são apenas exemplos para teste. Podem ser removidos em produção.

## Próximos Passos

Após executar os arquivos SQL:

1. ✅ Atualizar o arquivo `backend/.env` com as credenciais do `api_user`
2. ✅ Verificar a conexão do backend com o banco
3. ✅ Testar as operações CRUD através da API
4. ✅ Acessar o frontend React Admin em http://localhost:3001
