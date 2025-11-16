# Configuração do Redis para Cache

A aplicação agora utiliza **Redis** como sistema de cache distribuído.

##  Requisitos

- **Redis Server** instalado e rodando
- Porta padrão: `6379`

##  Instalação do Redis

### macOS (usando Homebrew)
```bash
# Instalar Redis
brew install redis

# Iniciar Redis como serviço
brew services start redis

# Verificar se está rodando
redis-cli ping
# Deve retornar: PONG
```

### Linux (Ubuntu/Debian)
```bash
# Instalar Redis
sudo apt update
sudo apt install redis-server

# Iniciar Redis
sudo systemctl start redis

# Habilitar na inicialização
sudo systemctl enable redis

# Verificar status
sudo systemctl status redis
```

### Windows

#### Opção 1: WSL2 (Recomendado)
```bash
# No WSL2 (Ubuntu), instalar Redis
sudo apt update
sudo apt install redis-server

# Iniciar Redis
sudo service redis-server start

# Verificar se está rodando
redis-cli ping
# Deve retornar: PONG
```

#### Opção 2: Memurai (Fork do Redis para Windows)
1. Baixe o instalador em: https://www.memurai.com/get-memurai
2. Execute o instalador
3. Redis será instalado como serviço do Windows
4. Verifique no PowerShell:
```powershell
redis-cli ping
```

#### Opção 3: Redis Insight + Docker (Melhor para desenvolvimento)
```powershell
# No PowerShell ou CMD, execute:
docker run --name redis-cache -p 6379:6379 -d redis:7-alpine

# Verificar se está rodando
docker ps | findstr redis

# Testar conexão
redis-cli ping
```

**Nota**: Para usar Docker no Windows, você precisa ter o Docker Desktop instalado.

### Docker (todas as plataformas)
```bash
# Rodar Redis em container
docker run --name redis-cache -p 6379:6379 -d redis:7-alpine

# Verificar se está rodando
docker ps | grep redis
```

##  Configuração

As variáveis de ambiente no arquivo `.env`:

```properties
# Redis
REDIS_HOST=localhost        # Host do Redis
REDIS_PORT=6379            # Porta do Redis
REDIS_PASSWORD=            # Senha (opcional, deixe vazio se não tiver)
REDIS_TTL=300              # Tempo de vida do cache em segundos (5 minutos)
```

## 🔍 Verificar Conexão

### Via CLI
```bash
# Conectar ao Redis
redis-cli

# Testar ping
127.0.0.1:6379> ping
PONG

# Ver todas as chaves
127.0.0.1:6379> KEYS *

# Ver valor de uma chave específica
127.0.0.1:6379> GET "pratos:list:0:10:criadoEm:DESC"

# Limpar todo o cache
127.0.0.1:6379> FLUSHALL
```

##  Monitoramento

### Ver comandos em tempo real
```bash
redis-cli MONITOR
```

### Ver informações do servidor
```bash
redis-cli INFO
```

### Ver uso de memória
```bash
redis-cli INFO memory
```

##  Estrutura das Chaves de Cache

A aplicação usa os seguintes padrões de chaves:

- `pratos:list:{start}:{end}:{sort}:{order}` - Lista de pratos com paginação
- `pratos:{id}` - Prato individual por ID
- `usuarios:list:{start}:{end}:{sort}:{order}` - Lista de usuários
- `usuarios:{id}` - Usuário individual
- `grupos:list:{start}:{end}:{sort}:{order}` - Lista de grupos
- `grupos:{id}` - Grupo individual
- `ingredientes:prato:{pratoId}` - Ingredientes de um prato específico

##  Gerenciamento de Cache

### Limpar cache específico
```bash
# Limpar todos os pratos
redis-cli --scan --pattern "pratos:*" | xargs redis-cli DEL

# Limpar cache de um prato específico
redis-cli DEL "pratos:abc-123-def-456"

# Limpar todos os caches de lista
redis-cli --scan --pattern "*:list:*" | xargs redis-cli DEL
```

### TTL (Time To Live)
O cache expira automaticamente após o tempo definido em `REDIS_TTL` (padrão: 300 segundos = 5 minutos).

Para verificar quanto tempo falta para uma chave expirar:
```bash
redis-cli TTL "pratos:list:0:10:criadoEm:DESC"
```

##  Troubleshooting

### Erro: "ECONNREFUSED"
O Redis não está rodando. Inicie o servidor:
```bash
# macOS
brew services start redis

# Linux
sudo systemctl start redis

# Windows (WSL2)
sudo service redis-server start

# Windows (Memurai) - Já inicia automaticamente como serviço
# Verifique no Gerenciador de Serviços do Windows

# Docker
docker start redis-cache
```

### Erro: "NOAUTH Authentication required"
Configure a senha no `.env`:
```properties
REDIS_PASSWORD=sua-senha-aqui
```

### Cache não está funcionando
Verifique se o Redis está acessível:
```bash
redis-cli ping
```

Verifique os logs da aplicação:
```bash
npm run start:dev
```

##  Voltar para Cache em Memória

Se preferir usar cache em memória ao invés do Redis, edite `src/app.module.ts`:

```typescript
// Substituir a configuração do Redis por:
CacheModule.register({
  isGlobal: true,
  ttl: 300,
  max: 100,
}),
```

E desinstalar as dependências do Redis:
```bash
npm uninstall cache-manager-redis-yet redis
```

##  Benefícios do Redis

-  **Cache distribuído**: Múltiplas instâncias da API compartilham o mesmo cache
-  **Persistência**: Cache sobrevive a reinicializações da aplicação
-  **Performance**: Operações extremamente rápidas (microsegundos)
-  **Escalabilidade**: Suporta grandes volumes de dados
-  **Monitoramento**: Ferramentas robustas para análise e debug

##  Segurança em Produção

1. **Sempre use senha** no Redis em produção
2. **Configure firewall** para permitir acesso apenas de IPs confiáveis
3. **Use conexão TLS** se o Redis estiver em servidor remoto
4. **Limite o tamanho do cache** com `maxmemory` e política de remoção

Exemplo de configuração Redis em produção:
```properties
REDIS_HOST=redis.producao.com
REDIS_PORT=6380
REDIS_PASSWORD=senha-forte-aqui
REDIS_TTL=600
```
