# Guia de Instalação e Configuração - Menu API

##  Pré-requisitos

Antes de começar, certifique-se de ter instalado:
- **Node.js** (v18 ou superior)
- **MySQL** (v8 ou superior)
- **Redis** (v6 ou superior)
- **npm** ou **yarn**

##  Passo a Passo

### 1. Instalar as dependências

```bash
cd backend
npm install
```

### 2. Configurar o banco de dados MySQL

Execute o script SQL para criar o banco de dados e as tabelas:

```bash
mysql -u root -p < ../bd/schema.sql
```

Ou através do MySQL Workbench/phpMyAdmin, execute o conteúdo do arquivo `bd/schema.sql`.

### 3. Configurar o Redis

**macOS (via Homebrew):**
```bash
brew install redis
brew services start redis
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get install redis-server
sudo systemctl start redis-server
```

**Docker:**
```bash
docker run -d -p 6379:6379 redis:latest
```

### 4. Configurar variáveis de ambiente

O arquivo `.env` já foi criado com as configurações padrão. Edite-o se necessário:

```env
DB_HOST=localhost
DB_PORT=3306
DB_USERNAME=root
DB_PASSWORD=sua_senha_mysql
DB_DATABASE=menu_db

REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=
REDIS_TTL=300

JWT_SECRET=meu-secret-super-secreto-mude-em-producao
JWT_EXPIRATION=1d

PORT=3000
NODE_ENV=development
```

### 5. Executar a aplicação

**Modo desenvolvimento:**
```bash
npm run start:dev
```

**Modo produção:**
```bash
npm run build
npm run start:prod
```

### 6. Acessar a aplicação

- **API**: http://localhost:3000
- **Documentação Swagger**: http://localhost:3000/api

##  Credenciais Padrão

O script SQL cria um usuário administrador padrão:

- **Email**: admin@menu.com
- **Senha**: admin123

** IMPORTANTE:** Altere esta senha em produção!

##  Endpoints Principais

### Autenticação
- `POST /auth/login` - Realizar login

### Usuários (requer autenticação)
- `GET /usuarios` - Listar usuários
- `POST /usuarios` - Criar usuário (apenas admin)
- `GET /usuarios/:id` - Buscar usuário
- `PATCH /usuarios/:id` - Atualizar usuário (apenas admin)
- `DELETE /usuarios/:id` - Deletar usuário (apenas admin)

### Grupos (requer autenticação)
- `GET /grupos` - Listar grupos
- `GET /grupos/:id` - Buscar grupo

### Pratos (público para leitura)
- `GET /pratos` - Listar pratos
- `GET /pratos?tipo=vegano` - Filtrar por tipo
- `GET /pratos?origem=brasileira` - Filtrar por origem
- `GET /pratos/:id` - Buscar prato
- `POST /pratos` - Criar prato (admin/nutricionista)
- `PATCH /pratos/:id` - Atualizar prato (admin/nutricionista)
- `DELETE /pratos/:id` - Deletar prato (admin/nutricionista)

### Ingredientes
- `GET /ingredientes/prato/:pratoId` - Listar ingredientes de um prato
- `GET /ingredientes/:id` - Buscar ingrediente

##  Testando a API

### 1. Fazer login

```bash
curl -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@menu.com",
    "senha": "admin123"
  }'
```

Copie o `accessToken` retornado.

### 2. Listar pratos (não requer autenticação)

```bash
curl http://localhost:3000/pratos
```

### 3. Criar um prato (requer autenticação)

```bash
curl -X POST http://localhost:3000/pratos \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer SEU_TOKEN_AQUI" \
  -d '{
    "nome": "Salada Caesar",
    "tipo": "vegetariano",
    "origem": "americana",
    "descricao": "Salada com alface romana, croutons e molho caesar",
    "calorias": 180,
    "proteinas": 8,
    "carboidratos": 15,
    "gorduras": 12,
    "ingredientes": [
      {"nome": "Alface romana"},
      {"nome": "Croutons"},
      {"nome": "Queijo parmesão"},
      {"nome": "Molho caesar"}
    ]
  }'
```

##  Roles e Permissões

### Administrador
- Acesso total a todas as rotas
- CRUD de usuários, grupos e pratos

### Nutricionista
- Criar, editar e visualizar pratos
- Visualizar usuários (sem editar)

### Usuário Comum
- Visualizar pratos (acesso público, não requer autenticação)
- Filtrar pratos por tipo e origem

##  Solução de Problemas

### Erro de conexão com MySQL
- Verifique se o MySQL está rodando: `mysql.server status` (macOS) ou `sudo systemctl status mysql` (Linux)
- Verifique as credenciais no arquivo `.env`
- Certifique-se de que o banco `menu_db` foi criado

### Erro de conexão com Redis
- Verifique se o Redis está rodando: `redis-cli ping` (deve retornar "PONG")
- Inicie o Redis: `brew services start redis` (macOS) ou `sudo systemctl start redis` (Linux)

### Porta já em uso
- Mude a porta no arquivo `.env`: `PORT=3001`

##  Scripts Disponíveis

```bash
npm run start          # Iniciar em modo normal
npm run start:dev      # Iniciar em modo desenvolvimento (watch mode)
npm run start:prod     # Iniciar em modo produção
npm run build          # Compilar o projeto
npm run lint           # Executar linter
npm run format         # Formatar código
npm run test           # Executar testes
```

## 🔗 Integração com React Admin

Esta API está preparada para ser consumida pelo React Admin. A documentação OpenAPI pode ser exportada em `http://localhost:3000/api-json` para gerar automaticamente os componentes do React Admin.

## 📄 Licença

MIT
