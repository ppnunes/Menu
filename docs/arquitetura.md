# Estrutura do Projeto Menu API

## 📁 Estrutura de Diretórios

```
backend/
├── src/
│   ├── auth/                      # Módulo de autenticação
│   │   ├── dto/                   # Data Transfer Objects
│   │   │   └── login.dto.ts       # DTO de login
│   │   ├── auth.controller.ts     # Controller de autenticação
│   │   ├── auth.service.ts        # Serviço de autenticação
│   │   ├── auth.module.ts         # Módulo de autenticação
│   │   └── jwt.strategy.ts        # Estratégia JWT do Passport
│   │
│   ├── users/                     # Módulo de usuários
│   │   ├── dto/                   # Data Transfer Objects
│   │   │   └── usuario.dto.ts     # DTOs de usuário
│   │   ├── usuario.entity.ts      # Entidade TypeORM
│   │   ├── users.controller.ts    # Controller CRUD
│   │   ├── users.service.ts       # Lógica de negócio
│   │   └── users.module.ts        # Módulo de usuários
│   │
│   ├── grupos/                    # Módulo de grupos (roles)
│   │   ├── grupo.entity.ts        # Entidade TypeORM
│   │   ├── grupos.controller.ts   # Controller
│   │   ├── grupos.service.ts      # Serviço
│   │   └── grupos.module.ts       # Módulo de grupos
│   │
│   ├── pratos/                    # Módulo de pratos
│   │   ├── dto/                   # Data Transfer Objects
│   │   │   └── prato.dto.ts       # DTOs de prato
│   │   ├── prato.entity.ts        # Entidade TypeORM
│   │   ├── pratos.controller.ts   # Controller CRUD
│   │   ├── pratos.service.ts      # Lógica de negócio + Cache
│   │   └── pratos.module.ts       # Módulo de pratos
│   │
│   ├── ingredientes/              # Módulo de ingredientes
│   │   ├── ingrediente.entity.ts  # Entidade TypeORM
│   │   ├── ingredientes.controller.ts
│   │   ├── ingredientes.service.ts
│   │   └── ingredientes.module.ts
│   │
│   ├── common/                    # Código compartilhado
│   │   ├── decorators/            # Decorators customizados
│   │   │   ├── roles.decorator.ts      # Decorator @Roles
│   │   │   └── current-user.decorator.ts # Decorator @CurrentUser
│   │   └── guards/                # Guards de segurança
│   │       ├── jwt-auth.guard.ts       # Guard JWT
│   │       └── roles.guard.ts          # Guard de roles
│   │
│   ├── app.module.ts              # Módulo raiz da aplicação
│   └── main.ts                    # Ponto de entrada
│
├── .env                           # Variáveis de ambiente
├── .env.example                   # Exemplo de variáveis
├── package.json                   # Dependências
├── tsconfig.json                  # Configuração TypeScript
├── nest-cli.json                  # Configuração NestJS CLI
├── README.md                      # Documentação principal
└── SETUP.md                       # Guia de instalação

bd/
└── schema.sql                     # Script SQL do banco
```

## 🔑 Conceitos Principais

### Entidades (TypeORM)

As entidades representam as tabelas do banco de dados:

- **Usuario**: Dados dos usuários com relacionamento M:N com Grupo
- **Grupo**: Roles do sistema (administrador, nutricionista, usuario_comum)
- **Prato**: Pratos com informações nutricionais
- **Ingrediente**: Ingredientes de cada prato

### DTOs (Data Transfer Objects)

DTOs definem a estrutura dos dados para entrada/saída da API:

- Validação automática com `class-validator`
- Documentação automática com decorators do Swagger
- Transformação de dados com `class-transformer`

### Guards

Guards controlam o acesso às rotas:

- **JwtAuthGuard**: Verifica se o usuário está autenticado
- **RolesGuard**: Verifica se o usuário tem as roles necessárias

### Decorators

Decorators customizados facilitam o uso:

- **@Roles(...roles)**: Define as roles necessárias para acessar uma rota
- **@CurrentUser()**: Injeta o usuário autenticado no parâmetro

### Cache (Redis)

O serviço de pratos usa Redis para cache:

- Cache automático em operações de leitura
- Invalidação de cache em operações de escrita
- TTL configurável (padrão: 300 segundos)

## 🔐 Autenticação e Autorização

### Fluxo de Autenticação

1. Usuário faz POST em `/auth/login` com email e senha
2. API valida credenciais
3. API retorna JWT token
4. Cliente inclui token no header: `Authorization: Bearer TOKEN`
5. Guards validam o token em cada requisição protegida

### Hierarquia dos Grupos de Usuários

```
administrador
├── CRUD de usuários
├── CRUD de grupos
└── CRUD de pratos

nutricionista
├── CRUD de pratos
└── Leitura de usuários

usuario_comum
└── Leitura pública de pratos (não requer autenticação)
```

## 🎯 Endpoints por Role

### Públicos (sem autenticação)
- `GET /pratos`
- `GET /pratos/:id`
- `GET /pratos?tipo=...`
- `GET /pratos?origem=...`
- `POST /auth/login`

### Nutricionista
- Todos os públicos +
- `POST /pratos`
- `PATCH /pratos/:id`
- `DELETE /pratos/:id`
- `GET /usuarios`
- `GET /usuarios/:id`

### Administrador
- Todos os anteriores +
- `POST /usuarios`
- `PATCH /usuarios/:id`
- `DELETE /usuarios/:id`
- `GET /grupos`
- `GET /grupos/:id`

## 🗄️ Banco de Dados

### Relacionamentos

```
Usuario M:N Grupo (via grupo_usuario)
Prato 1:N Ingrediente
```

### Triggers

O banco possui triggers para:
- Gerar UUID automaticamente em todas as inserções
- Atualizar `atualizado_em` quando um prato é modificado
- Atualizar `atualizado_em` do prato quando ingredientes são modificados

### Views

Views para acesso simplificado:
- `view_pratos_veganos`
- `view_pratos_vegetarianos`
- `view_pratos_onivoros`
- `view_pratos_brasileiros`
- `view_pratos_franceses`
- `view_pratos_indianos`
- `view_pratos_completos` (com ingredientes)

## 🚀 Fluxo de Requisição

```
Cliente → Controller → Guard → Service → Repository → Database
                ↓                 ↓
            Validation        Cache (Redis)
                ↓
          Transformação
                ↓
           Response
```

## 📊 Swagger/OpenAPI

A documentação da API é gerada automaticamente em `/api`:

- Esquemas de todas as entidades
- Exemplos de requisições
- Códigos de resposta
- Testes interativos
- Exportação para JSON (`/api-json`)


## 📚 Referências

- [Documentação NestJS](https://docs.nestjs.com/)
- [TypeORM](https://typeorm.io/)
- [Swagger/OpenAPI](https://swagger.io/)
- [JWT](https://jwt.io/)
- [Redis](https://redis.io/)
