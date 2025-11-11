Projeto de catalogo de pratos online que armazena lista de ingredientes e tabela nutricional de cada prato.

Para o banco de dados é utilizado MySQL, contendo tabelas usuario, grupo, grupo_usuario, prato, ingredientes. É necessário ter índices de tipo de comida (vegano, vegetariano, onívaro) e de origem (brasileira, francesa, indiana), triggers que serão responsáveis por atualizar as colunas criado_em e atualizado_em nas tabelas prato, 

O prato deve conter:
 - tipo
 - origem
 - nome
 - id
 - a tabela nutricional do prato (calorias,proteinas,carboidratos, gorduras, etc)

A tabela de ingredientes deve conter apenas o ingrediente presentes no prato, sem a necessidade de informar as quantidades.

A tabela grupo deve conter as possiveis roles no banco de dados, como Administrador, nutricionista, usuário_comum

A tabela usuário deve conter as informações básicas do usuário, além do campo para a senha dele

A tabela grupo_usuario deve servir apenas pra relacionar usuários e grupos

Deve ser utilizado uuid para a criação dos id de todas as tabelas, podemos utilizar um trigger para a criação destes ids

A aplicação utiliza NestJS com um banco MySQL. Utiliza também um banco redis para cache. Ela deve exportar a api com OpenAPI para ser utilizado com o react-admin para consumir as rotas e gerar uma tela administrativa que permite o acesso de diferentes níveis de roles. No banco de dados há 3 tipos de roles distintas:
- administrador: Terá acesso a completo ao echema da minha aplicação, mas nao tem acesso root;
- nutricionista: Terá acesso a escrita e atualização da tabela prato;
- usuario_comum: Terá acesso de leitura a views que mostram pratos filtrados por tipo e origem, seus ingredientes e a tabela nutricional do prato.

Para frontend, utilizaremos o React Admin, consumindo a saída da OpenAPI gerada pela API.