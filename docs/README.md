# 📚 Documentação do Projeto Menu

Bem-vindo à documentação completa do projeto Menu - Catálogo de Pratos com informações nutricionais.

## 📖 Índice de Documentação

### 📋 Especificação e Planejamento
- **[leiame.md](./leiame.md)** - Documento de requisitos e especificação original do projeto

### 🏗️ Arquitetura e Setup
- **[ARCHITECTURE.md](./ARCHITECTURE.md)** - Documentação da arquitetura do backend NestJS
- **[SETUP.md](./SETUP.md)** - Guia completo de configuração e instalação do projeto
- **[QUICKSTART.md](./QUICKSTART.md)** - Guia rápido para começar a desenvolver

### 🔧 Infraestrutura e Cache
- **[REDIS.md](./REDIS.md)** - Guia completo de configuração e uso do Redis
- **[MIGRATION_REDIS.md](./MIGRATION_REDIS.md)** - Documentação da migração para Redis

## 📂 Estrutura do Projeto

```
Menu/
├── docs/              # 📚 Toda a documentação do projeto
├── backend/           # 🔧 API NestJS
│   └── README.md     # Documentação específica do backend
├── frontend/          # 🎨 Interface React Admin
│   └── README.md     # Documentação específica do frontend
├── bd/                # 🗄️ Scripts SQL
│   ├── schema.sql    # DDL - Estrutura do banco
│   ├── dados.sql     # DML - Dados iniciais
│   └── README.md     # Documentação do banco
└── README.md          # 📘 README principal do projeto
```

## 🚀 Links Rápidos

### Para Desenvolvedores
1. [Começar rapidamente](./QUICKSTART.md)
2. [Setup completo](./SETUP.md)
3. [Arquitetura do sistema](./ARCHITECTURE.md)

### Para DevOps
1. [Configuração do Redis](./REDIS.md)
2. [Migração e troubleshooting](./MIGRATION_REDIS.md)

### Para Product Owners
1. [Requisitos do projeto](./leiame.md)

## 📝 Convenções de Documentação

- **README.md** - Documentação principal de cada módulo (backend, frontend, bd)
- **ARCHITECTURE.md** - Decisões de arquitetura e padrões de código
- **SETUP.md** - Guias detalhados de instalação e configuração
- **QUICKSTART.md** - Guias rápidos para começar
- **Arquivos específicos** (REDIS.md, etc) - Documentação focada em tecnologias específicas

## 🔄 Manutenção da Documentação

Esta documentação deve ser atualizada sempre que:
- ✅ Novas funcionalidades forem adicionadas
- ✅ A arquitetura do sistema mudar
- ✅ Dependências ou requisitos forem alterados
- ✅ Processos de deploy ou configuração mudarem

## 📞 Suporte

Para dúvidas ou problemas:
1. Consulte primeiro esta documentação
2. Verifique os README.md específicos de cada módulo
3. Consulte os arquivos de troubleshooting (MIGRATION_REDIS.md, REDIS.md)
