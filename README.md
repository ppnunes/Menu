#  Projeto Menu - Catálogo de Pratos Online

Sistema completo de gerenciamento de pratos com informações nutricionais, autenticação e controle de acesso baseado em roles.

## Estrutura do Projeto

```
Menu/
├── backend/           # API NestJS
├── frontend/          # Interface React Admin
├── bd/                # Scripts SQL
└── docs/              #  Documentação completa do projeto
```

## Início Rápido

### 1.Configurar Banco de Dados

```bash
# Criar banco MySQL
mysql -u root -p < bd/schema.sql
```

### 2. Iniciar Backend

```bash
cd backend
npm install
npm run start:dev
```

Backend rodando em: **http://localhost:3000**
Documentação API: **http://localhost:3000/api**

### 3. Iniciar Frontend

```bash
cd frontend
npm install
npm run dev
```

Frontend rodando em: **http://localhost:3001**

### 4. Login

- **Email**: admin@menu.com
- **Senha**: admin123

## Tecnologias Utilizadas

### Backend
- **NestJS** - Framework Node.js progressivo
- **TypeORM** - ORM para TypeScript
- **MySQL** - Banco de dados relacional
- **Redis** - Cache em memória
- **JWT** - Autenticação
- **Swagger/OpenAPI** - Documentação da API
- **Passport** - Estratégias de autenticação

### Frontend
- **React 18** - Biblioteca JavaScript
- **React Admin 4** - Framework administrativo
- **Material-UI 5** - Componentes UI
- **Vite** - Build tool
- **TypeScript** - Superset tipado do JavaScript

### Banco de Dados
- **MySQL 8** - Banco principal
- **Views** - Para acesso otimizado
- **Triggers** - Para automação de dados
- **Índices** - Para otimização de consultas
- **Funções e Procedures** - Para facilitar operações mais complexas

## Modelo de Dados

### Tabelas Principais

- **usuario** - Dados dos usuários
- **grupo** - Roles do sistema
- **grupo_usuario** - Relacionamento usuários e grupos
- **prato** - Pratos com tabela nutricional
- **ingrediente** - Ingredientes de cada prato

### Views Disponíveis

- `view_pratos_veganos`
- `view_pratos_vegetarianos`
- `view_pratos_onivoros`
- `view_pratos_brasileiros`
- `view_pratos_franceses`
- `view_pratos_indianos`
- `view_pratos_completos` (com ingredientes)

## Sistema de Permissões (RBAC)

### Administrador
-  Acesso completo ao sistema
-  CRUD de usuários
-  CRUD de grupos
-  CRUD de pratos
-  Visualizar estatísticas

### Nutricionista
-  CRUD de pratos
-  Gerenciar ingredientes

### Usuário Comum
-  Visualizar pratos
-  Filtrar por tipo e origem
-  Ver informações nutricionais
-  Ver ingredientes

##  Funcionalidades

### Dashboard
- Estatísticas do sistema
- Total de pratos por categoria
- Informações do usuário logado

### Gestão de Pratos
- Criar, editar e deletar pratos
- Adicionar informações nutricionais completas
- Gerenciar lista de ingredientes
- Filtrar por tipo (vegano, vegetariano, onívoro)
- Filtrar por origem (brasileira, francesa, indiana, etc.)
- Exportar dados

### Gestão de Usuários (Admin)
- Criar e gerenciar usuários
- Atribuir grupos
- Ativar/desativar usuários
- Visualizar histórico

### API RESTful
- Documentação Swagger automática
- Autenticação JWT
- Cache Redis para performance
- Validação de dados
- Tratamento de erros

##  Estrutura de Diretórios

### Backend
```
backend/src/
├── auth/           # Autenticação JWT
├── users/          # Gerenciamento de usuários
├── grupos/         # Roles do sistema
├── pratos/         # Catálogo de pratos
├── ingredientes/   # Ingredientes
├── common/         # Guards, decorators
├── app.module.ts
└── main.ts
```

### Frontend
```
frontend/src/
├── resources/      # Recursos CRUD
│   ├── pratos.tsx
│   ├── usuarios.tsx
│   └── grupos.tsx
├── App.tsx
├── Dashboard.tsx
├── authProvider.ts
└── dataProvider.ts
```

## Configuração

### Backend (.env)
```env
DB_HOST=localhost
DB_PORT=3306
DB_USERNAME=root
DB_PASSWORD=
DB_DATABASE=menu_db

REDIS_HOST=localhost
REDIS_PORT=6379

JWT_SECRET=seu-secret-aqui
JWT_EXPIRATION=1d

PORT=3000
```

### Frontend (.env)
```env
VITE_API_URL=http://localhost:3000
```

## Documentação

Para documentação completa, acesse a pasta [docs/](./docs/):

- **[Especificações do Projeto](./docs/leiame.md)** - Requisitos e especificações originais
- **[Arquitetura](./docs/ARCHITECTURE.md)** - Decisões de arquitetura e padrões
- **[Setup Completo](./docs/SETUP.md)** - Guia detalhado de instalação
- **[Quick Start](./docs/QUICKSTART.md)** - Começar rapidamente
- **[Redis](./docs/REDIS.md)** - Configuração e uso do cache
- **[Migração Redis](./docs/MIGRATION_REDIS.md)** - Histórico e troubleshooting

### Documentação por Módulo

#### Backend
- `backend/README.md` - Visão geral da API
- `docs/ARCHITECTURE.md` - Arquitetura detalhada
- `docs/SETUP.md` - Guia de instalação

#### Frontend
- `frontend/README.md` - Documentação completa
- `docs/QUICKSTART.md` - Início rápido

#### Banco de Dados
- `bd/README.md` - Guia dos scripts SQL
- `bd/schema.sql` - DDL (estrutura)
- `bd/dados.sql` - DML (dados iniciais)

### API
- Acesse: http://localhost:3000/api
- Documentação interativa Swagger
- Testes de endpoints
- Exemplos de requisições

##  Testando a API

### Login
```bash
curl -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@menu.com","senha":"admin123"}'
```

### Listar Pratos
```bash
curl http://localhost:3000/pratos
```

### Criar Prato (com autenticação)
```bash
curl -X POST http://localhost:3000/pratos \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer SEU_TOKEN" \
  -d '{
    "nome": "Salada Caesar",
    "tipo": "vegetariano",
    "origem": "americana",
    "calorias": 180,
    "proteinas": 8,
    "ingredientes": [
      {"nome": "Alface"},
      {"nome": "Croutons"}
    ]
  }'
```

## Fluxo de Trabalho

1. **Usuário acessa o frontend** (http://localhost:3001)
2. **Faz login** com email e senha
3. **Backend valida** credenciais no MySQL
4. **Retorna JWT token** para autenticação
5. **Frontend armazena** token no localStorage
6. **Requisições incluem** token no header Authorization
7. **Backend valida** token e permissões
8. **Redis cacheia** dados de pratos para performance
9. **Dados retornam** para o frontend
10. **Interface renderiza** conteúdo baseado em permissões

## Performance

- **Cache Redis**: Respostas de leitura de pratos em cache
- **Índices MySQL**: Otimização de consultas
- **Views**: Pré-processamento de dados filtrados
- **Lazy Loading**: Carregamento sob demanda no frontend
- **Code Splitting**: Divisão de código no build

##  Segurança

- Senhas hasheadas com bcrypt
- Autenticação JWT
- Validação de dados com class-validator
- Guards para proteção de rotas
- CORS configurado
- Sanitização de inputs
- Prepared statements (SQL injection protection)

##  Troubleshooting

### Backend não inicia
- Verifique se MySQL está rodando
- Verifique se Redis está rodando
- Confirme credenciais no `.env`

### Frontend não conecta
- Verifique se backend está rodando
- Confirme CORS no backend
- Verifique console do navegador

### Erro de autenticação
- Limpe localStorage: `localStorage.clear()`
- Verifique credenciais
- Confirme JWT_SECRET no backend

## Autores

Priscila Nunes, Anna Beatriz Nascimento Reis, Camile Eduarda Cordeiro Felix, Fabiana Souza De Paula, Emanoel Alexandre Barbosa Batista,Erick Ferreira Dos Santos.


## Suporte

- **[Documentação Completa](./docs/)** - Toda a documentação do projeto
- Documentação Backend: `backend/README.md`
- Documentação Frontend: `frontend/README.md`
- Documentação Banco: `bd/README.md`
- API Docs: http://localhost:3000/api
- Issues: Crie uma issue no repositório
