# Menu Admin - Interface Administrativa

Interface administrativa construída com React Admin para gerenciar o catálogo de pratos.

## 🚀 Tecnologias

- **React 18** - Biblioteca JavaScript para construção de interfaces
- **React Admin 4** - Framework para interfaces administrativas
- **Material-UI 5** - Componentes React baseados em Material Design
- **Vite** - Build tool rápido e moderno
- **TypeScript** - Superset tipado do JavaScript

## 📋 Pré-requisitos

- Node.js (v18 ou superior)
- npm ou yarn
- Backend rodando em http://localhost:3000

## 🔧 Instalação

### 1. Instalar dependências

```bash
cd frontend
npm install
```

### 2. Configurar variáveis de ambiente

O arquivo `.env` já está criado com as configurações padrão:

```env
VITE_API_URL=http://localhost:3000
```

### 3. Iniciar o servidor de desenvolvimento

```bash
npm run dev
```

A aplicação estará disponível em: **http://localhost:3001**

## 🔐 Login

Use as credenciais padrão do backend:

- **Email**: admin@menu.com
- **Senha**: admin123

## 📱 Funcionalidades

### Dashboard
- Visão geral do sistema
- Estatísticas de pratos e usuários
- Informações de permissões do usuário logado

### Pratos
- **Listagem**: Visualizar todos os pratos com filtros por tipo e origem
- **Criar**: Adicionar novos pratos com informações nutricionais (admin/nutricionista)
- **Editar**: Atualizar informações de pratos existentes (admin/nutricionista)
- **Visualizar**: Ver detalhes completos incluindo ingredientes
- **Exportar**: Exportar lista de pratos

### Usuários (apenas Administrador)
- **Listagem**: Ver todos os usuários cadastrados
- **Criar**: Adicionar novos usuários
- **Editar**: Atualizar informações de usuários
- **Visualizar**: Ver detalhes completos do usuário

### Grupos (apenas Administrador)
- **Listagem**: Ver todos os grupos (roles) do sistema

### Ingredientes
- **Listagem**: Ver todos os ingredientes
- **Visualizar**: Detalhes de ingredientes específicos

## 🎭 Controle de Acesso (RBAC)

### Administrador
- ✅ Acesso completo a todas as funcionalidades
- ✅ CRUD de usuários
- ✅ CRUD de pratos
- ✅ Visualizar grupos

### Nutricionista
- ✅ CRUD de pratos
- ✅ Visualizar usuários (sem editar)
- ✅ Visualizar ingredientes

### Usuário Comum
- ✅ Visualizar pratos
- ✅ Filtrar pratos por tipo e origem
- ✅ Ver detalhes de pratos e ingredientes

## 🎨 Características da Interface

### Design Responsivo
- Interface adaptável para desktop, tablet e mobile
- Navegação otimizada para diferentes tamanhos de tela

### Filtros Avançados
- Filtrar pratos por tipo (vegano, vegetariano, onívoro)
- Filtrar por origem (brasileira, francesa, indiana, etc.)
- Busca por nome

### Internacionalização
- Interface completamente em português
- Mensagens de erro e validação traduzidas

### Validação de Formulários
- Validação em tempo real
- Mensagens de erro claras
- Campos obrigatórios destacados

## 📁 Estrutura do Projeto

```
frontend/
├── src/
│   ├── resources/          # Recursos da aplicação
│   │   ├── pratos.tsx      # CRUD de pratos
│   │   ├── usuarios.tsx    # CRUD de usuários
│   │   └── grupos.tsx      # Listagem de grupos
│   ├── App.tsx             # Componente principal
│   ├── Dashboard.tsx       # Dashboard principal
│   ├── LoginPage.tsx       # Página de login
│   ├── Layout.tsx          # Layout personalizado
│   ├── AppBar.tsx          # Barra superior
│   ├── authProvider.ts     # Provedor de autenticação
│   ├── dataProvider.ts     # Provedor de dados
│   └── index.tsx           # Ponto de entrada
├── index.html
├── vite.config.ts
├── tsconfig.json
└── package.json
```

## 🛠️ Scripts Disponíveis

```bash
npm run dev      # Iniciar servidor de desenvolvimento
npm run build    # Compilar para produção
npm run preview  # Visualizar build de produção
```

## 🔗 Integração com Backend

A aplicação se comunica com o backend através da API REST:

- **Base URL**: http://localhost:3000
- **Autenticação**: JWT Bearer Token
- **Formato**: JSON

### Endpoints Utilizados

```
POST   /auth/login           # Login
GET    /pratos               # Listar pratos
POST   /pratos               # Criar prato
GET    /pratos/:id           # Ver prato
PATCH  /pratos/:id           # Atualizar prato
DELETE /pratos/:id           # Deletar prato
GET    /usuarios             # Listar usuários
POST   /usuarios             # Criar usuário
GET    /usuarios/:id         # Ver usuário
PATCH  /usuarios/:id         # Atualizar usuário
DELETE /usuarios/:id         # Deletar usuário
GET    /grupos               # Listar grupos
GET    /ingredientes         # Listar ingredientes
```

## 🎯 Próximos Passos

1. **Personalização**
   - Modificar cores e tema em `src/App.tsx`
   - Adicionar logo personalizada
   - Customizar dashboard

2. **Funcionalidades Adicionais**
   - Relatórios e gráficos
   - Upload de imagens de pratos
   - Histórico de alterações
   - Busca avançada

3. **Otimizações**
   - Implementar paginação
   - Cache de dados
   - Lazy loading de componentes

## 🐛 Solução de Problemas

### Erro de CORS
Se encontrar erros de CORS, certifique-se de que o backend está configurado para aceitar requisições de `http://localhost:3001`.

### Erro de Autenticação
- Verifique se o backend está rodando
- Confirme que as credenciais estão corretas
- Limpe o localStorage: `localStorage.clear()`

### Erro ao Carregar Dados
- Verifique a conexão com o backend
- Confirme que está autenticado
- Verifique o console do navegador para mais detalhes

## 📚 Documentação

- [React Admin](https://marmelab.com/react-admin/)
- [Material-UI](https://mui.com/)
- [Vite](https://vitejs.dev/)
- [React](https://react.dev/)

## 🤝 Integração com React Admin

Este projeto foi configurado para consumir automaticamente a API OpenAPI do backend. O React Admin:

- Gera automaticamente formulários baseados nos schemas
- Valida dados conforme as regras da API
- Gerencia autenticação e permissões
- Oferece componentes prontos para CRUD

## 📄 Licença

MIT

## 👥 Suporte

Para problemas ou dúvidas:
1. Verifique a documentação do React Admin
2. Consulte os logs do console do navegador
3. Verifique se o backend está respondendo corretamente
