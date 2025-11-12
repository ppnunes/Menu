# Sistema Menu - Catálogo de Pratos com Informações Nutricionais

Este documento explica de forma clara e objetiva como funciona o sistema de catálogo de pratos, pensado para ser compreendido por qualquer pessoa, mesmo sem conhecimentos técnicos.

---

## 1. O Que é o Sistema Menu?

É uma aplicação web (site) onde pessoas podem:
- **Consultar pratos** de diferentes tipos (vegano, vegetariano, onívoro)
- **Ver informações nutricionais** (calorias, proteínas, carboidratos, etc.)
- **Conhecer os ingredientes** de cada prato
- **Filtrar por origem** (brasileira, italiana, japonesa, etc.)

### Para que serve?
Imagine um cardápio digital inteligente que além de mostrar os pratos disponíveis, também informa tudo sobre sua composição nutricional. Útil para:
- Restaurantes que querem oferecer transparência aos clientes
- Pessoas com restrições alimentares (veganos, vegetarianos)
- Quem quer controlar a alimentação e saber o que está consumindo
- Nutricionistas que precisam de informações precisas dos pratos

---

## 2. Como o Sistema Organiza as Informações?

Assim como em um escritório usamos arquivos e pastas para organizar documentos, o sistema usa **bancos de dados** para guardar informações de forma organizada.

### 2.1 O Arquivo Principal (MySQL)

Imagine uma **grande estante com gavetas** onde cada gaveta guarda um tipo específico de informação. No nosso sistema, temos 5 "gavetas" principais:

**Gaveta 1 - Usuários** 📋
- Guarda informações de quem usa o sistema
- Exemplo: Nome, email, senha (protegida)
- Como uma ficha cadastral de cada pessoa

**Gaveta 2 - Grupos** 👥
- Define os tipos de usuário (administrador, nutricionista, cliente)
- Como os crachás em uma empresa: cada um com permissões diferentes

**Gaveta 3 - Ligação Usuário-Grupo** 🔗
- Conecta cada usuário ao seu grupo
- É como dizer: "João é um cliente" ou "Maria é nutricionista"

**Gaveta 4 - Pratos** 🍽️
- A estrela do sistema! Guarda:
  - Nome do prato (ex: "Feijoada Vegana")
  - Tipo (vegano, vegetariano, onívoro)
  - Origem (brasileira, italiana, etc.)
  - Informações nutricionais completas
  - Se está disponível ou não

**Gaveta 5 - Ingredientes** 🥕
- Lista todos os ingredientes de cada prato
- Exemplo: Feijoada Vegana tem: feijão preto, proteína de soja, cebola, alho...

### Como as Gavetas se Conectam?

Pense como uma receita de bolo:
- **Um prato** pode ter **vários ingredientes** (1 para muitos)
- **Um usuário** pode ter **vários grupos** e um grupo pode ter **vários usuários** (muitos para muitos)

### 2.2 Atalhos para Buscar Mais Rápido (Índices)

**O que são?**
Imagine que você tem uma agenda telefônica gigante. Sem ordem alfabética, levaria horas para achar um número. Os **índices** funcionam como o índice alfabético de um livro - fazem você achar a informação rapidinho!

**Onde usamos atalhos no sistema?**

| O que você quer achar | Como o atalho ajuda |
|----------------------|---------------------|
| **Usuário pelo email** | Quando você faz login, o sistema acha sua conta instantaneamente |
| **Pratos veganos** | Ao filtrar "só pratos veganos", a lista aparece super rápido |
| **Pratos italianos** | Mesma coisa: filtro por país funciona veloz |
| **Ingredientes de um prato** | Ao clicar em um prato, os ingredientes aparecem na hora |
| **Buscar por nome** | Digite "Feijoada" e já acha todos os tipos |

**Por que isso é importante?**
Sem esses atalhos, buscar em um catálogo de 1.000 pratos demoraria vários segundos. Com atalhos, demora menos de 1 segundo! É como comparar procurar um livro em uma biblioteca bagunçada vs. uma organizada por ordem alfabética.

### 2.3 Automações Inteligentes (Triggers)

**O que são?**
São como "assistentes automáticos" que fazem tarefas chatas automaticamente, sem você precisar lembrar.

**Temos 9 assistentes trabalhando para nós:**

**Assistente 1 a 5: Criadores de Códigos Únicos**
- **O que fazem:** Quando você cadastra algo novo (usuário, prato, grupo), eles criam um código único e impossível de repetir
- **Por exemplo:** Ao cadastrar "Feijoada Vegana", recebe código: `a1b2c3d4-e5f6-7890-abcd-ef1234567890`
- **Por que usar códigos assim?** 
  - Cada prato no mundo inteiro tem código diferente
  - Não dá conflito se duas pessoas cadastram ao mesmo tempo
  - Mais seguro que números sequenciais (1, 2, 3...)

**Assistente 6: Atualizador de Data**
- **O que faz:** Toda vez que você edita um prato, ele anota automaticamente a data e hora
- **Exemplo prático:** Você mudou as calorias da Feijoada? O sistema registra: "Alterado em 12/11/2025 às 14:30"
- **Por que é útil:** Você sabe exatamente quando foi a última modificação

**Assistentes 7, 8 e 9: Sincronizadores de Ingredientes**
- **O que fazem:** Quando você adiciona, modifica ou remove um ingrediente, eles automaticamente atualizam a data do prato
- **Exemplo:** 
  - Você adiciona "pimenta" na Feijoada
  - O assistente atualiza: "Prato modificado agora mesmo"
- **Por que importa:** O sistema sabe que houve mudança e atualiza as informações para todo mundo ver

**Comparação do mundo real:**
Imagine uma biblioteca. Quando alguém pega um livro emprestado, o bibliotecário anota isso numa fichinha. Os triggers fazem exatamente isso, mas automaticamente - você não precisa lembrar de anotar nada!

### 2.4 Visões Pré-Filtradas (Views)

**O que são?**
Imagine que todo dia você vai ao supermercado e quer ver só produtos veganos. Em vez de olhar prateleira por prateleira, o supermercado cria uma **seção exclusiva** só com veganos. Views são isso: seções especiais!

**Temos 7 "seções" prontas:**

1. **Seção Vegana** 🌱
   - Mostra apenas pratos 100% veganos
   - Como ter um cardápio vegano separado

2. **Seção Vegetariana** 🥗
   - Só pratos vegetarianos (podem ter leite, ovo, queijo)
   - Filtro automático de vegetarianos

3. **Seção Onívora** 🍖
   - Pratos com carne, peixe, frango
   - Para quem come de tudo

4. **Seção Brasileira** 🇧🇷
   - Só comida brasileira (feijoada, moqueca, pão de queijo...)
   - Como ter um menu "só Brasil"

5. **Seção Francesa** 🇫🇷
   - Culinária francesa (ratatouille, quiche, boeuf bourguignon...)

6. **Seção Indiana** 🇮🇳
   - Pratos indianos (curry, tikka masala, chana masala...)

7. **Seção Completa** 📋
   - Mostra tudo: prato + lista de ingredientes numa tacada só
   - Exemplo: "Feijoada Vegana - Ingredientes: feijão preto, soja, cebola, alho..."

**Por que usar seções?**
- **Mais rápido:** Não precisa procurar um por um
- **Mais organizado:** Cada pessoa vê só o que interessa
- **Mais seguro:** Usuários comuns só veem essas seções, não mexem diretamente nos arquivos principais

**Exemplo prático:**
João é vegetariano. Ao abrir o app, ele vê direto a "Seção Vegetariana" com 20 opções. Não precisa ficar checando prato por prato se tem carne ou não!

---

## 1.2 Sistema de Memória Rápida (Redis - NoSQL)

### O que é Redis?

**Imagine sua memória de curto prazo:**
Quando você lê um número de telefone e precisa lembrar dele por alguns segundos para discar, você usa sua memória de curto prazo. O Redis funciona assim!

**Diferença do MySQL:**
- **MySQL** = Arquivo gigante bem organizado (guarda tudo para sempre)
- **Redis** = Post-it com lembretes (guarda temporariamente o que você usa muito)

### Para que serve no nosso sistema?

**Situação sem Redis:**
1. Maria abre o app
2. Sistema busca no MySQL todos os pratos (demora 2 segundos)
3. João abre o app 5 segundos depois
4. Sistema busca no MySQL DE NOVO os mesmos pratos (mais 2 segundos!)
5. Ana abre o app...
6. Sistema busca OUTRA VEZ... (cansativo!)

**Situação COM Redis:**
1. Maria abre o app
2. Sistema busca no MySQL (demora 2 segundos)
3. **Sistema salva no Redis** (como guardar num post-it)
4. João abre o app 5 segundos depois
5. Sistema lê do Redis (demora 0,1 segundo! 20x mais rápido!)
6. Ana abre o app...
7. Sistema lê do Redis (0,1 segundo de novo!)

**Por que não guardar tudo no Redis para sempre?**
- Redis guarda só na memória RAM (como um rascunho)
- RAM é cara e limitada
- MySQL guarda no HD (arquivo permanente, barato, grande)

**Comparação perfeita:**
- **MySQL** = Biblioteca (milhares de livros, consulta demora mais)
- **Redis** = Sua mesa de estudos (5 livros que você usa hoje, pega rapidinho)

### O que guardamos no Redis?

| O que guardamos | Por quanto tempo | Por quê? |
|----------------|------------------|----------|
| **Lista de pratos** | 5 minutos | Muita gente vê os pratos, mas eles não mudam a cada segundo |
| **Detalhes de um prato** | 5 minutos | Quando você clica num prato, as informações já estão prontas |
| **Sessão de login** | 24 horas | Você não precisa fazer login toda hora |
| **Filtros comuns** | 5 minutos | "Pratos veganos" é consultado várias vezes por minuto |

**Tempo de expiração:**
Imagine que você deixa um post-it na geladeira: "Tem bolo". Depois de 5 minutos, você joga fora o post-it e vai conferir de novo se ainda tem bolo. Redis faz isso automaticamente!

### Por que escolhemos Redis?

**Existem outras opções de memória rápida:**
- **Memcached** (concorrente direto)
- **MongoDB** (banco completo, não só cache)

**Por que Redis ganhou:**

✅ **Mais tipos de informação**
- Redis entende listas, conjuntos, textos
- Memcached entende só texto simples
- *Exemplo:* Conseguimos guardar "lista dos 10 pratos mais vistos" organizada

✅ **Mais seguro**
- Redis pode salvar no HD de vez em quando
- Se der problema, não perde tudo
- Memcached perde tudo se desligar

✅ **Mais usado no mundo**
- Instagram usa Redis
- Twitter usa Redis
- Milhões de apps usam
- Mais fácil achar ajuda quando trava

✅ **Funciona bem com NestJS**
- NestJS (nossa tecnologia) já vem pronto para Redis
- Configuração leva 5 minutos
- MongoDB precisaria de muito mais código

**Desvantagens (e por que não importam aqui):**
- ❌ Redis usa mais memória que Memcached
  - *Mas:* Nosso app é pequeno, não importa
- ❌ Redis é um pouco mais complicado de configurar
  - *Mas:* NestJS já facilita tudo

### Como funciona na prática?

**Fluxo de uma busca COM cache:**

```
Você: "Quero ver pratos veganos"
       ↓
App: "Deixa eu ver se lembro..." (olha no Redis)
       ↓
Redis: "Lembro sim! Aqui: 15 pratos veganos" (0,1 segundo)
       ↓
Você: Vê os pratos instantaneamente! ⚡
```

**Fluxo quando Redis não lembra (primeira vez ou expirou):**

```
Você: "Quero ver pratos veganos"
       ↓
App: "Deixa eu ver se lembro..." (olha no Redis)
       ↓
Redis: "Não lembro, foi há muito tempo"
       ↓
App: "Tá, vou buscar no arquivo principal" (busca no MySQL - 2 segundos)
       ↓
MySQL: "Achei! 15 pratos veganos"
       ↓
App: "Deixa eu anotar num post-it" (guarda no Redis)
       ↓
Você: Vê os pratos (demorou 2 segundos dessa vez)
       ↓
Próxima pessoa: Vai ver em 0,1 segundo! (Redis já lembra)
```

**Benefícios reais:**
- 🚀 **Velocidade:** 20x mais rápido
- 💰 **Economia:** MySQL trabalha menos, servidor aguenta mais usuários
- 😊 **Experiência:** App parece muito mais rápido e responsivo

---

## 1.3 Segurança e Controle de Acesso

### O que são Funções e Papéis?

**Imagine uma empresa:**
- **Gerente:** Pode contratar, demitir, ver salários
- **Vendedor:** Pode vender, ver estoque, não vê salários
- **Estagiário:** Pode ver estoque, não pode vender

Nosso sistema funciona IGUAL! Cada pessoa tem um "cargo" que define o que pode fazer.

### Nossos 4 Grupos (Cargos)

**1. 👑 Administrador**
- **Pode fazer:** TUDO (criar usuários, deletar pratos, mudar tudo)
- **Quem é:** Dono do sistema
- **Exemplo:** Carlos é admin, consegue até deletar o app inteiro se quiser

**2. 🥗 Nutricionista**
- **Pode fazer:** Criar e editar pratos, gerenciar ingredientes
- **NÃO pode:** Deletar outros usuários, mexer em configurações
- **Quem é:** Profissional que monta os cardápios
- **Exemplo:** Dra. Ana adiciona informações nutricionais nos pratos

**3. 👤 Usuário Comum**
- **Pode fazer:** Ver pratos, buscar receitas, favoritar
- **NÃO pode:** Editar nada, criar pratos
- **Quem é:** Você e eu usando o app
- **Exemplo:** João só quer ver receitas veganas para fazer em casa

**4. 👨‍🍳 Cozinha**
- **Pode fazer:** Ver receitas detalhadas, marcar pratos como "preparados"
- **NÃO pode:** Editar receitas, criar usuários
- **Quem é:** Pessoal que prepara a comida
- **Exemplo:** Chef Maria vê a receita de Feijoada e prepara 50 porções


### Como funciona a segurança?

**Sistema de cadeado triplo:**

**🔐 Nível 1: Login (Quem é você?)**
- Você digita email e senha
- Sistema confere se está certo
- Se correto, ganha uma "credencial" (como um crachá)

**🔐 Nível 2: Grupo (Qual seu cargo?)**
- Sistema olha: "Ah, você é Nutricionista"
- Libera só funções de nutricionista
- Esconde botões de admin

**🔐 Nível 3: Ação (Pode fazer isso?)**
- Você tenta deletar um prato
- Sistema confere: "Nutricionista pode deletar?"
- Se não pode: "Acesso negado!"

**Exemplo prático:**

```
João (usuário comum) tenta deletar Feijoada:
  1. Sistema: "Você está logado? ✅ Sim"
  2. Sistema: "Você é admin? ❌ Não, é usuário comum"
  3. Sistema: "Usuário comum pode deletar? ❌ NÃO"
  4. Resultado: ⛔ "Você não tem permissão"

Dra. Ana (nutricionista) tenta deletar Feijoada:
  1. Sistema: "Você está logado? ✅ Sim"
  2. Sistema: "Você é admin ou nutricionista? ✅ Sim, nutricionista"
  3. Sistema: "Nutricionista pode deletar? ✅ SIM"
  4. Resultado: ✅ "Feijoada deletada com sucesso"
```

### Segurança no Banco de Dados MySQL

**Temos 2 usuários técnicos no MySQL:**

**🔧 api_user (Mantenedor)**
- **O que faz:** É o usuário que o app usa para funcionar
- **Pode:** Criar, ler, editar pratos e usuários
- **Não pode:** Deletar o banco inteiro
- **Analogia:** Funcionário da biblioteca que organiza livros, mas não pode demolir o prédio

**🔍 testador (Qualidade)**  
- **O que faz:** Usuário para conferir se está tudo certo
- **Pode:** Só LER (ver pratos, usuários, ingredientes)
- **Não pode:** Mudar NADA
- **Analogia:** Inspetor que vistoria mas não mexe em nada

**Por que ter 2 usuários técnicos?**
- Se alguém invadir a conta de testador, não consegue estragar nada (só lê)
- Se api_user der problema, testador ainda funciona para diagnosticar
- Princípio de segurança: "Cada um só tem o poder que precisa"

---

## 2. Frontend - A Parte que Você Vê e Clica

### O que é Frontend?

**Imagine um restaurante:**
- **Frontend** = Salão, cardápio, garçom (o que você vê e interage)
- **Backend** = Cozinha (onde a mágica acontece, mas você não vê)

O Frontend é TUDO que aparece na sua tela: botões, cores, textos, formulários.

### Nossa tecnologia: React Admin

**O que é React Admin?**
É como um "kit de construção" para criar telas de administração. Em vez de desenhar cada botão do zero, usamos peças prontas.

**Analogia:**
- **Sem React Admin:** Construir uma casa tijolo por tijolo
- **Com React Admin:** Comprar casa pré-fabricada e só decorar

**O que vem pronto:**
✅ Tela de login
✅ Listas (de pratos, usuários, etc)
✅ Formulários (cadastrar prato novo)
✅ Botões de editar/deletar
✅ Filtros e buscas
✅ Design bonito e profissional

**O que precisamos personalizar:**
🎨 Cores da nossa marca
📝 Textos em português
🍽️ Campos específicos (nome do prato, calorias, etc)

### Telas principais do sistema

**1. 🔐 Tela de Login**
- Campos: Email e Senha
- O que faz: Confere se você está cadastrado
- Se correto: Entra no sistema
- Se errado: Mostra "Email ou senha incorretos"

**2. 📋 Lista de Pratos**
- Mostra todos os pratos em formato de tabela
- Cada linha: Nome, Tipo (vegano/vegetariano/onívoro), Origem, Calorias
- Botões: Ver detalhes, Editar, Deletar
- Filtros no topo: "Só veganos", "Só brasileiros", etc

**3. ➕ Cadastrar Novo Prato**
- Formulário com campos:
  - Nome do prato
  - Tipo (vegano/vegetariano/onívoro)
  - Origem (brasileira/italiana/etc)
  - Descrição
  - Calorias, Proteínas, Carboidratos
  - Lista de ingredientes
- Botão: "Salvar"

**4. ✏️ Editar Prato**
- Mesmos campos do cadastro, mas já preenchidos
- Você muda o que quiser
- Botão: "Atualizar"

**5. 👥 Gerenciar Usuários** (só administradores veem)
- Lista de todos os usuários
- Pode criar novo usuário
- Pode mudar o "cargo" (grupo) de alguém
- Pode desativar usuário

### Como o Frontend se comunica com o Backend?

**Imagine um drive-thru:**
- **Você (Frontend):** Faz pedido no interfone
- **Interfone (API):** Transmite pedido
- **Cozinha (Backend):** Prepara pedido
- **Interfone:** Devolve pedido pronto
- **Você:** Recebe e come

**No nosso sistema:**

```
Você clica: "Ver pratos veganos"
       ↓
Frontend: Envia pedido → "GET /pratos?tipo=vegano"
       ↓
Backend: Recebe pedido → Busca no MySQL/Redis
       ↓
Backend: Acha 15 pratos → Envia de volta
       ↓
Frontend: Recebe 15 pratos → Mostra na tela
       ↓
Você: Vê a lista linda e organizada!
```

**Linguagem de comunicação:**
- Frontend fala **HTTP/JSON** (formato universal de internet)
- Backend responde em **JSON** (texto organizado que computadores entendem)

**Exemplo de conversa:**

Frontend pergunta:
```
"Me dá os pratos veganos"
```

Backend responde:
```
{
  "pratos": [
    {"nome": "Feijoada Vegana", "calorias": 450},
    {"nome": "Moqueca Vegana", "calorias": 380},
    ...
  ]
}
```

Frontend traduz e mostra bonito na tela:
- ✅ Feijoada Vegana - 450 cal
- ✅ Moqueca Vegana - 380 cal

---

## 3. Backend - A Cozinha do Sistema

### O que é Backend?

Lembra do restaurante? Se Frontend é o salão, **Backend é a cozinha!**

**Você não vê:**
- Como o chef corta a cebola
- Onde estão guardados os temperos
- Como o fogão funciona

**Mas precisa funcionar bem:**
- Receber pedidos corretos
- Preparar rapidinho
- Entregar perfeito

### Nossa tecnologia: NestJS

**O que é NestJS?**
É um "kit profissional de cozinha" para criar sistemas de backend. Vem com tudo organizado e pronto para trabalhar.

**Analogia:**
- **Sem NestJS:** Cozinha bagunçada, cada coisa num canto
- **Com NestJS:** Cozinha industrial organizada, cada coisa no lugar certo

**O que vem pronto:**
✅ Sistema de rotas (qual pedido vai para onde)
✅ Conexão com banco de dados (MySQL e Redis)
✅ Sistema de segurança (quem pode fazer o quê)
✅ Validação de dados (se você digitou errado, avisa)
✅ Organização de código (tudo separadinho)

### Como o Backend funciona?

**Fluxo de um pedido simples:**

```
1. Frontend: "Quero ver o prato 'Feijoada'"
       ↓
2. Backend recebe: "OK, vou buscar"
       ↓
3. Olha no Redis: "Feijoada está aqui?" 
       ↓
4. Se SIM: Pega do Redis (0,1 segundo) ✅
   Se NÃO: Vai no MySQL buscar (2 segundos)
       ↓
5. Encontrou? Envia para Frontend
   Não encontrou? Envia "Prato não existe"
```

**Componentes principais:**

**1. 🚪 Controladores (Controllers)**
- **O que fazem:** Recebem pedidos e mandam para quem resolve
- **Analogia:** Garçom que anota pedido e leva para cozinha
- **Exemplo:** "Controller de Pratos" recebe todas as ações sobre pratos

**2. ⚙️ Serviços (Services)**
- **O que fazem:** Fazem o trabalho pesado (buscar no banco, calcular, validar)
- **Analogia:** Chef que realmente cozinha
- **Exemplo:** "Service de Pratos" busca, cria, edita, deleta pratos

**3. 🗄️ Repositórios (Repositories)**
- **O que fazem:** Conversam direto com o banco de dados
- **Analogia:** Despensa onde ficam os ingredientes
- **Exemplo:** "Repository de Pratos" sabe exatamente onde estão os pratos no MySQL

**4. 🛡️ Guards (Seguranças)**
- **O que fazem:** Checam se você pode fazer aquilo
- **Analogia:** Segurança da balada que checa sua carteirinha
- **Exemplo:** "AuthGuard" confere se você está logado

### Operações que o Backend faz

**📖 Ler (GET):**
```
Pedido: "Quero ver todos os pratos"
Backend faz:
  1. Checa se você está logado
  2. Busca no cache (Redis)
  3. Se não tem, busca no MySQL
  4. Guarda no cache
  5. Envia para você
```

**➕ Criar (POST):**
```
Pedido: "Quero cadastrar 'Brigadeiro Vegano'"
Backend faz:
  1. Checa se você pode criar (é nutricionista ou admin?)
  2. Valida dados ("tem todos os campos?")
  3. Gera código único (UUID)
  4. Salva no MySQL
  5. Limpa cache antigo
  6. Confirma: "Criado com sucesso!"
```

**✏️ Editar (PUT):**
```
Pedido: "Quero mudar calorias da Feijoada"
Backend faz:
  1. Checa permissão
  2. Busca prato no MySQL
  3. Atualiza informação
  4. Trigger atualiza data automaticamente
  5. Limpa cache
  6. Confirma: "Atualizado!"
```

**🗑️ Deletar (DELETE):**
```
Pedido: "Quero deletar Brigadeiro"
Backend faz:
  1. Checa permissão (só admin e nutricionista)
  2. Marca como "inativo" (não deleta de verdade)
  3. Limpa cache
  4. Confirma: "Deletado!"
```

**Por que não deleta de verdade?**
- Segurança: Se deletar por engano, consegue recuperar
- Histórico: Fica registrado que existiu
- Relatórios: Consegue fazer estatísticas depois

### Conexão com os Bancos de Dados

**MySQL (Arquivo permanente):**
```typescript
// Configuração simplificada
Conecta em: localhost:3306
Banco: menu_db
Usuário: api_user
Senha: api_senha_123
```

**Redis (Memória rápida):**
```typescript
// Configuração simplificada
Conecta em: localhost:6379
Tempo de vida: 5 minutos
Salva: Listas de pratos, detalhes
```

**Como decide onde buscar:**
```
Pedido chega
    ↓
Tenta Redis primeiro (rápido)
    ↓
Achou? → Retorna (0,1s)
    ↓
Não achou? → Busca MySQL (2s)
    ↓
Salva no Redis para próxima vez
    ↓
Retorna
```

### Validações e Segurança

**Validação de dados:**
- Nome do prato: Mínimo 3 letras, máximo 100
- Calorias: Tem que ser número positivo
- Email: Tem que ter @ e .com (ou similar)
- Senha: Mínimo 8 caracteres

**Exemplo de erro:**
```
Você tenta cadastrar: Nome = "Ab" (só 2 letras)
Backend bloqueia: "Nome deve ter no mínimo 3 caracteres"
```

**Criptografia de senha:**
- Você digita: "minhasenha123"
- Sistema guarda: "$2b$10$xKjzP..." (embaralhado)
- Por quê? Se alguém roubar o banco, não consegue ver senhas de verdade

**Tokens de autenticação (JWT):**
- Quando você loga, ganha um "passe VIP"
- Passe dura 24 horas
- Toda ação, mostra o passe
- Passe expirou? Precisa logar de novo

---

## 4. Como Tudo Funciona Junto - Integração Completa

### Visão Geral do Sistema

Imagine uma **fábrica com 3 setores:**

```
┌──────────────┐      ┌──────────────┐      ┌──────────────┐
│   FRONTEND   │ ←──→ │   BACKEND    │ ←──→ │  BANCO DADOS │
│  (Tela)      │      │   (Lógica)   │      │  (Arquivo)   │
│              │      │              │      │              │
│  React Admin │      │   NestJS     │      │  MySQL       │
│              │      │              │      │  +           │
│              │      │  ↕️          │      │  Redis       │
│              │      │  Cache       │      │              │
└──────────────┘      └──────────────┘      └──────────────┘
```

### Fluxo Completo: Você Busca um Prato

**Passo a passo detalhado:**

**1. Você digita e clica**
```
Você: Abre tela → Digita "Feijoada" → Clica "Buscar"
Frontend: "Beleza, vou pedir ao Backend"
```

**2. Frontend faz pedido ao Backend**
```
Frontend envia:
  Método: GET
  URL: http://localhost:3001/pratos?nome=Feijoada
  Headers: { Authorization: "seu-token-de-login" }
```

**3. Backend recebe e valida**
```
Backend:
  ✅ Checa token: "Está logado? SIM"
  ✅ Checa permissão: "Pode ver pratos? SIM"
  ✅ Valida busca: "Nome válido? SIM"
```

**4. Backend tenta cache (Redis)**
```
Backend pergunta Redis:
  "Tem resultado para busca 'Feijoada'?"
  
Redis responde:
  Cenário A: "SIM! Aqui: 3 tipos de Feijoada" (0,1 segundo)
  Cenário B: "NÃO, não tenho" (vai para passo 5)
```

**5. Se Redis não tem: Busca no MySQL**
```
Backend pergunta MySQL:
  "SELECT * FROM prato WHERE nome LIKE '%Feijoada%'"
  
MySQL responde:
  "Achei 3 pratos!" (demora 2 segundos)
  
Backend salva no Redis:
  "Guarda isso aqui por 5 minutos"
```

**6. Backend envia resposta ao Frontend**
```
Backend responde:
  Status: 200 OK
  Dados: [
    {"id": 1, "nome": "Feijoada Tradicional", "calorias": 650},
    {"id": 2, "nome": "Feijoada Vegana", "calorias": 450},
    {"id": 3, "nome": "Feijoada Light", "calorias": 400}
  ]
```

**7. Frontend mostra para você**
```
Frontend recebe e exibe:
  
  🍲 Resultados para "Feijoada"
  
  ┌────────────────────────────────────┐
  │ Feijoada Tradicional - 650 cal    │
  │ [Ver] [Editar] [Deletar]          │
  ├────────────────────────────────────┤
  │ Feijoada Vegana - 450 cal         │
  │ [Ver] [Editar] [Deletar]          │
  ├────────────────────────────────────┤
  │ Feijoada Light - 400 cal          │
  │ [Ver] [Editar] [Deletar]          │
  └────────────────────────────────────┘
```

### Fluxo Completo: Você Cria um Prato Novo

**Cenário:** Você é nutricionista e quer cadastrar "Tapioca Vegana"

**1. Você preenche formulário**
```
Tela de cadastro:
  Nome: Tapioca Vegana
  Tipo: Vegano
  Origem: Brasileira
  Descrição: Tapioca recheada com vegetais
  Calorias: 250
  Proteínas: 8
  Carboidratos: 45
  Ingredientes: Tapioca, tomate, alface, cenoura
  
[Botão: SALVAR]
```

**2. Frontend valida antes de enviar**
```
Frontend checa:
  ✅ Nome preenchido? SIM
  ✅ Tipo selecionado? SIM
  ✅ Calorias é número? SIM
  ✅ Todos obrigatórios preenchidos? SIM
```

**3. Frontend envia ao Backend**
```
Frontend envia:
  Método: POST
  URL: http://localhost:3001/pratos
  Headers: { Authorization: "seu-token" }
  Corpo: {
    "nome": "Tapioca Vegana",
    "tipo": "vegano",
    "origem": "brasileira",
    "descricao": "Tapioca recheada com vegetais",
    "calorias": 250,
    "proteinas": 8,
    "carboidratos": 45,
    "ingredientes": ["Tapioca", "tomate", "alface", "cenoura"]
  }
```

**4. Backend valida e processa**
```
Backend:
  ✅ Checa login e permissão (é nutricionista? SIM)
  ✅ Valida dados novamente (segurança dupla)
  ✅ Gera UUID: "a1b2c3d4-e5f6-..."
  ✅ Cria registro no MySQL
  ✅ Trigger adiciona data de criação automaticamente
  ✅ Cria ingredientes vinculados
  ✅ Limpa cache de "lista de pratos" no Redis
```

**5. MySQL executa triggers automaticamente**
```
Trigger 1: Gera UUID para o prato
Trigger 2: Define data de criação = AGORA
View atualizada: Tapioca agora aparece em "view_pratos_veganos"
```

**6. Backend confirma sucesso**
```
Backend responde:
  Status: 201 Created
  Dados: {
    "id": "a1b2c3d4-e5f6-...",
    "nome": "Tapioca Vegana",
    "mensagem": "Prato criado com sucesso!"
  }
```

**7. Frontend mostra confirmação**
```
Tela mostra:
  ✅ Prato criado com sucesso!
  
  [Redireciona para lista de pratos]
  
Lista agora mostra Tapioca Vegana no topo!
```

### O Papel do Cache (Redis) na Integração

**Problema sem cache:**
```
10 pessoas acessam ao mesmo tempo
    ↓
10 buscas no MySQL (demora 20 segundos total)
    ↓
MySQL fica sobrecarregado
    ↓
Sistema fica lento 🐌
```

**Solução com cache:**
```
Pessoa 1 acessa
    ↓
Busca MySQL (2 segundos)
    ↓
Guarda no Redis
    ↓
Pessoas 2-10 acessam
    ↓
Busca Redis (0,1 segundo cada = 1 segundo total)
    ↓
Sistema continua rápido! ⚡
```

**Quando o cache é limpo:**
- Quando você CRIA um prato novo
- Quando você EDITA um prato
- Quando você DELETA um prato
- Quando os 5 minutos acabam (expiração automática)

**Por que limpar?**
Se não limpar, pessoas veem informação antiga:
```
Você muda Feijoada: 650 → 600 calorias
Cache ainda tem: 650 calorias (ERRADO!)
Próxima pessoa vê: 650 calorias (informação antiga)

Solução: Backend limpa cache ao editar
Próxima pessoa: Busca MySQL atualizado (600 calorias certo!)
```

### Segurança em Todas as Camadas

**Camada 1: Frontend**
```
Validação no navegador:
  - Email tem @?
  - Senha tem 8+ caracteres?
  - Campos obrigatórios preenchidos?
```

**Camada 2: Backend**
```
Validação no servidor:
  - Token válido?
  - Usuário tem permissão?
  - Dados corretos?
  - SQL injection bloqueado?
```

**Camada 3: Banco de Dados**
```
Controle MySQL:
  - Usuário api_user pode escrever?
  - Usuário testador só lê?
  - Triggers funcionando?
```

**Exemplo de ataque bloqueado:**
```
Hacker tenta:
  Nome do prato: "'; DROP TABLE prato; --"
  (tentativa de apagar tabela inteira!)

Backend bloqueia:
  ❌ "Caracteres inválidos no nome"
  
Banco está SEGURO! 🛡️
```

---

## 5. Conclusão - Por Que Tudo Isso Importa?

### Resumo em Linguagem Simples

Criamos um **sistema completo de catálogo de pratos** que funciona como uma máquina bem azeitada:

**🗄️ Arquivo Organizado (MySQL)**
- Guarda tudo certinho para sempre
- Índices fazem buscas serem rápidas
- Triggers automatizam tarefas chatas
- Views filtram informações automaticamente

**⚡ Memória Rápida (Redis)**
- Lembra das coisas mais usadas
- 20x mais rápido que buscar no arquivo
- Economiza trabalho do MySQL
- Expira automático para não ficar desatualizado

**🎨 Interface Bonita (React Admin)**
- Tela fácil de usar
- Botões grandes e claros
- Filtros automáticos
- Design profissional

**⚙️ Cozinha Eficiente (NestJS)**
- Processa pedidos rapidinho
- Valida tudo para evitar erros
- Protege contra ataques
- Conecta frontend e bancos de dados

**🔐 Segurança em 3 Níveis**
- Login obrigatório
- Cada pessoa só faz o que pode
- Senhas criptografadas
- Ataques bloqueados automaticamente

### Benefícios para Cada Tipo de Usuário

**👤 Usuário Comum (João):**
- ✅ Vê pratos instantaneamente (cache rápido)
- ✅ Filtros fáceis de usar (views prontas)
- ✅ Não vê botões que não pode usar (segurança)

**🥗 Nutricionista (Dra. Ana):**
- ✅ Cadastra pratos rapidamente (formulários prontos)
- ✅ Edita informações facilmente
- ✅ Vê estatísticas automaticamente (triggers e views)

**👨‍🍳 Cozinha (Chef Maria):**
- ✅ Acessa receitas completas (view_pratos_completos)
- ✅ Vê ingredientes organizados
- ✅ Marca preparações

**👑 Administrador (Carlos):**
- ✅ Cria novos usuários
- ✅ Define quem pode fazer o quê
- ✅ Vê estatísticas completas do sistema
- ✅ Controle total

**🔧 Técnico (Pedro - Mantenedor):**
- ✅ Conserta bugs no banco de dados
- ✅ Faz backups
- ✅ Otimiza performance
- ✅ Não pode apagar tudo (segurança)

**🔍 Testador (Júlia - Qualidade):**
- ✅ Confere se tudo está correto
- ✅ Vê todos os dados
- ✅ Não pode mudar nada (garante que teste não estraga)


### 🎯 Objetivos Alcançados:

1. **Sistema organizado e escalável**
   - Hoje: 54 pratos
   - Amanhã: Pode ter 10.000 pratos sem problemas
   - Índices e cache garantem velocidade

2. **Seguro contra ataques**
   - Senhas criptografadas
   - SQL injection bloqueado
   - Permissões em 3 camadas

3. **Rápido e eficiente**
   - Cache Redis: 20x mais rápido
   - Índices: Busca em milissegundos
   - Views: Filtros automáticos

4. **Fácil de usar**
   - Interface intuitiva
   - Filtros automáticos
   - Formulários claros

5. **Automatizado**
   - Triggers fazem trabalho chato
   - Códigos únicos gerados automaticamente
   - Datas atualizadas sozinhas

### Tecnologias e Por Que Escolhemos

**📊 MySQL (Banco Relacional)**
- ✅ Confiável (usado no mundo todo há 25 anos)
- ✅ Grátis (código aberto)
- ✅ Rápido para nosso tamanho
- ✅ Fácil de aprender

**⚡ Redis (Cache)**
- ✅ Mais rápido cache disponível
- ✅ Usado por Instagram, Twitter
- ✅ Integração fácil com NestJS
- ✅ Economiza dinheiro de servidor

**🎨 React Admin (Frontend)**
- ✅ Interface profissional pronta
- ✅ Poupa 80% do tempo de desenvolvimento
- ✅ Design moderno e responsivo
- ✅ Comunidade enorme (ajuda fácil)

**⚙️ NestJS (Backend)**
- ✅ Organizado e estruturado
- ✅ TypeScript (previne erros)
- ✅ Segurança embutida
- ✅ Fácil de testar


---