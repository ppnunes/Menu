#!/bin/bash

# Script para verificar e configurar Redis

echo "🔍 Verificando Redis..."
echo ""

# Verificar se o Redis está instalado
if command -v redis-cli &> /dev/null; then
    echo "✅ Redis CLI está instalado"
else
    echo "❌ Redis CLI não encontrado"
    echo ""
    echo "Para instalar:"
    echo "  macOS:  brew install redis"
    echo "  Linux:  sudo apt install redis-server"
    echo "  Docker: docker run --name redis-cache -p 6379:6379 -d redis:7-alpine"
    exit 1
fi

echo ""

# Verificar se o Redis está rodando
if redis-cli ping &> /dev/null; then
    echo "✅ Redis está rodando"
    
    # Mostrar informações
    echo ""
    echo "📊 Informações do Redis:"
    redis-cli INFO server | grep "redis_version"
    redis-cli INFO server | grep "os"
    redis-cli INFO memory | grep "used_memory_human"
    
    echo ""
    echo "🔢 Estatísticas:"
    echo "  Total de chaves: $(redis-cli DBSIZE | awk '{print $2}')"
    
    echo ""
    echo "🔑 Últimas chaves (max 10):"
    redis-cli --scan --count 10
    
else
    echo "❌ Redis não está rodando"
    echo ""
    echo "Para iniciar:"
    echo "  macOS:  brew services start redis"
    echo "  Linux:  sudo systemctl start redis"
    echo "  Docker: docker start redis-cache"
    exit 1
fi

echo ""
echo "✨ Tudo pronto! O backend pode conectar ao Redis."
