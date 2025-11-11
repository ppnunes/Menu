# Menu API

API de catálogo de pratos com informações nutricionais, autenticação e controle de acesso baseado em roles.

## Características

- **NestJS** - Framework Node.js progressivo
- **TypeORM** - ORM para TypeScript e JavaScript
- **MySQL** - Banco de dados relacional
- **Redis** - Sistema de cache distribuído
- **JWT** - Autenticação via JSON Web Tokens
- **Swagger/OpenAPI** - Documentação automática da API
- **RBAC** - Controle de acesso baseado em roles (administrador, nutricionista, usuario_comum)

## Instalação

```bash
# Instalar dependências
npm install

# Configurar variáveis de ambiente
cp .env.example .env
# Edite o arquivo .env com suas configurações
```

## Banco de Dados

Execute os scripts SQL na pasta `bd/` para criar o banco de dados:

```bash
# 1. Criar estrutura (tabelas, views, triggers, etc)
mysql -u root -p < ../bd/schema.sql

# 2. Inserir dados iniciais
mysql -u root -p < ../bd/dados.sql
```

## Redis

A aplicação utiliza Redis para cache distribuído. Certifique-se de que o Redis está rodando:

```bash
# Verificar se Redis está rodando
redis-cli ping

# Se não estiver instalado:
# macOS:  brew install redis && brew services start redis
# Linux:  sudo apt install redis-server && sudo systemctl start redis
# Docker: docker run --name redis-cache -p 6379:6379 -d redis:7-alpine

# Verificar configuração (opcional)
./check-redis.sh
```

Para mais informações sobre Redis, consulte [../docs/REDIS.md](../docs/REDIS.md).

## Executar a aplicação

```bash
# Desenvolvimento
npm run start:dev

# Produção
npm run build
npm run start:prod
```

## Documentação da API

Acesse a documentação Swagger em: `http://localhost:3000/api`

## Roles e Permissões

### Administrador
- Acesso completo a todas as rotas
- CRUD de usuários, grupos e pratos

### Nutricionista
- Criar, editar e visualizar pratos
- Visualizar usuários

### Usuário Comum
- Visualizar pratos através de views filtradas
- Acesso somente leitura

## Estrutura do Projeto

```
src/
├── auth/           # Módulo de autenticação
├── users/          # Módulo de usuários
├── grupos/         # Módulo de grupos (roles)
├── pratos/         # Módulo de pratos
├── ingredientes/   # Módulo de ingredientes
├── common/         # Código compartilhado (guards, decorators, etc)
├── config/         # Configurações da aplicação
├── app.module.ts   # Módulo principal
└── main.ts         # Ponto de entrada da aplicação
```

## Testes

```bash
# Testes unitários
npm run test

# Testes e2e
npm run test:e2e

# Cobertura de testes
npm run test:cov
```

## 📚 Documentação Adicional

- [Arquitetura do Sistema](../docs/ARCHITECTURE.md) - Decisões de arquitetura e padrões
- [Guia de Setup](../docs/SETUP.md) - Instalação detalhada e configuração
- [Configuração do Redis](../docs/REDIS.md) - Cache distribuído
- [Migração para Redis](../docs/MIGRATION_REDIS.md) - Histórico e troubleshooting
- [Quick Start](../docs/QUICKSTART.md) - Começar rapidamente
