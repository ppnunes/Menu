# Migração para Redis - Resumo das Alterações

##  Pacotes Atualizados

### Removido
- `cache-manager-redis-store@3.0.1` (incompatível com cache-manager v5)

### Adicionado
- `cache-manager-redis-yet@5.1.5` (compatível com cache-manager v5)

##  Arquivos Modificados

### 1. `src/app.module.ts`
**Antes:** Cache em memória
```typescript
CacheModule.register({
  isGlobal: true,
  ttl: 300,
  max: 100,
}),
```

**Depois:** Cache com Redis
```typescript
CacheModule.registerAsync({
  isGlobal: true,
  inject: [ConfigService],
  useFactory: async (configService: ConfigService) => {
    const store = await redisStore({
      socket: {
        host: configService.get('REDIS_HOST', 'localhost'),
        port: configService.get('REDIS_PORT', 6379),
      },
      password: configService.get('REDIS_PASSWORD') || undefined,
      ttl: configService.get('REDIS_TTL', 300) * 1000,
    });
    
    return {
      store: () => store,
    };
  },
}),
```

### 2. Imports adicionados
```typescript
import { redisStore } from 'cache-manager-redis-yet';
```

## 📄 Arquivos Criados

1. **REDIS.md** - Documentação completa sobre:
   - Instalação do Redis
   - Configuração
   - Monitoramento
   - Troubleshooting
   - Estrutura de chaves
   - Segurança

2. **check-redis.sh** - Script para verificar:
   - Se Redis está instalado
   - Se Redis está rodando
   - Estatísticas e informações
   - Chaves existentes

##  Configuração no .env

As seguintes variáveis já existem e agora são utilizadas:

```properties
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=
REDIS_TTL=300
```

##  Próximos Passos

### 1. Instalar Redis (se ainda não tiver)

**macOS:**
```bash
brew install redis
brew services start redis
```

**Linux:**
```bash
sudo apt update
sudo apt install redis-server
sudo systemctl start redis
```

**Docker:**
```bash
docker run --name redis-cache -p 6379:6379 -d redis:7-alpine
```

### 2. Verificar Redis
```bash
redis-cli ping
# Deve retornar: PONG
```

ou usar o script:
```bash
chmod +x check-redis.sh
./check-redis.sh
```

### 3. Iniciar a aplicação
```bash
npm run start:dev
```

##  Como Verificar se está Funcionando

### 1. Monitorar Redis em tempo real
```bash
redis-cli MONITOR
```

### 2. Fazer uma requisição à API
```bash
curl http://localhost:3000/pratos
```

### 3. Ver as chaves criadas
```bash
redis-cli KEYS "*"
```

Você deve ver chaves como:
- `pratos:list:0:10:criadoEm:DESC`
- `usuarios:list:0:10:criadoEm:DESC`
- etc.

## 📊 Benefícios da Migração

### Antes (Cache em Memória)
-  Cache perdido ao reiniciar aplicação
-  Cada instância tem seu próprio cache
-  Limitado pela memória Node.js
-  Sem ferramentas de monitoramento

### Depois (Redis)
-  Cache persistente entre reinicializações
-  Cache compartilhado entre múltiplas instâncias
-  Escalável e de alta performance
-  Ferramentas robustas de monitoramento
-  TTL automático por chave
-  Suporte a operações complexas

##  Troubleshooting

### Erro: "Error: connect ECONNREFUSED 127.0.0.1:6379"
**Solução:** Redis não está rodando. Inicie-o:
```bash
brew services start redis  # macOS
sudo systemctl start redis # Linux
docker start redis-cache   # Docker
```

### Erro: "NOAUTH Authentication required"
**Solução:** Configure a senha no `.env`:
```properties
REDIS_PASSWORD=sua-senha
```

### Aplicação não usa Redis
**Verificar:** 
1. Redis está rodando? `redis-cli ping`
2. Porta correta? Verifique `REDIS_PORT` no `.env`
3. Logs da aplicação: `npm run start:dev`

##  Reverter para Cache em Memória

Se precisar voltar ao cache em memória:

1. Editar `src/app.module.ts`:
```typescript
CacheModule.register({
  isGlobal: true,
  ttl: 300,
  max: 100,
}),
```

2. Remover import:
```typescript
// Remover: import { redisStore } from 'cache-manager-redis-yet';
```

3. Desinstalar (opcional):
```bash
npm uninstall cache-manager-redis-yet redis
```

##  Documentação Adicional

- [REDIS.md](./REDIS.md) - Guia completo do Redis
- [README.md](./README.md) - Documentação principal
- [Redis Official Docs](https://redis.io/docs/)
