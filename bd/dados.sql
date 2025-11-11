-- ============================================
-- Dados do Projeto Menu - Catálogo de Pratos
-- DML - Data Manipulation Language
-- ============================================

USE menu_db;

-- ============================================
-- Inserção de dados iniciais - Grupos
-- ============================================

INSERT INTO grupo (id, nome, descricao) VALUES
(UUID(), 'administrador', 'Acesso completo ao schema da aplicação'),
(UUID(), 'nutricionista', 'Acesso de escrita e atualização na tabela prato'),
(UUID(), 'usuario_comum', 'Acesso de leitura às views de pratos filtrados'),
(UUID(), 'cozinha', 'Acesso de escrita e atualização nas tabelas prato e ingrediente');

-- ============================================
-- Usuário administrador padrão (OPCIONAL)
-- Senha: admin123 (deve ser alterada em produção)
-- ============================================

-- Descomente as linhas abaixo para criar o usuário administrador padrão

SET @admin_id = UUID();
SET @admin_grupo_id = (SELECT id FROM grupo WHERE nome = 'administrador');

INSERT INTO usuario (id, nome, email, senha) VALUES
(@admin_id, 'Administrador', 'admin@menu.com', '$2b$10$GtqbftrS7wkvOKh9hhp0LOMBDy9b.dC0DNNo5jEnJAKXW4qzqgiYa');

INSERT INTO grupo_usuario (id, usuario_id, grupo_id) VALUES
(UUID(), @admin_id, @admin_grupo_id);

-- ============================================
-- Usuários adicionais
-- ============================================

-- Usuário: Chef (grupo: cozinha)
-- Senha: chef123
SET @chef_id = UUID();
SET @cozinha_grupo_id = (SELECT id FROM grupo WHERE nome = 'cozinha');

INSERT INTO usuario (id, nome, email, senha) VALUES
(@chef_id, 'Chef', 'chef@menu.com', '$2b$10$GtqbftrS7wkvOKh9hhp0LOMBDy9b.dC0DNNo5jEnJAKXW4qzqgiYa');

INSERT INTO grupo_usuario (id, usuario_id, grupo_id) VALUES
(UUID(), @chef_id, @cozinha_grupo_id);

-- Usuário: João (grupo: usuario_comum)
-- Senha: joao123
SET @joao_id = UUID();
SET @usuario_comum_grupo_id = (SELECT id FROM grupo WHERE nome = 'usuario_comum');

INSERT INTO usuario (id, nome, email, senha) VALUES
(@joao_id, 'João', 'joao@menu.com', '$2b$10$GtqbftrS7wkvOKh9hhp0LOMBDy9b.dC0DNNo5jEnJAKXW4qzqgiYa');

INSERT INTO grupo_usuario (id, usuario_id, grupo_id) VALUES
(UUID(), @joao_id, @usuario_comum_grupo_id);

-- Usuário: Maria (grupo: usuario_comum)
-- Senha: maria123
SET @maria_id = UUID();

INSERT INTO usuario (id, nome, email, senha) VALUES
(@maria_id, 'Maria', 'maria@menu.com', '$2b$10$GtqbftrS7wkvOKh9hhp0LOMBDy9b.dC0DNNo5jEnJAKXW4qzqgiYa');

INSERT INTO grupo_usuario (id, usuario_id, grupo_id) VALUES
(UUID(), @maria_id, @usuario_comum_grupo_id);

-- Usuário: Nutri1 (grupo: nutricionista)
-- Senha: nutri123
SET @nutri1_id = UUID();
SET @nutricionista_grupo_id = (SELECT id FROM grupo WHERE nome = 'nutricionista');

INSERT INTO usuario (id, nome, email, senha) VALUES
(@nutri1_id, 'Nutri1', 'nutri1@menu.com', '$2b$10$GtqbftrS7wkvOKh9hhp0LOMBDy9b.dC0DNNo5jEnJAKXW4qzqgiYa');

INSERT INTO grupo_usuario (id, usuario_id, grupo_id) VALUES
(UUID(), @nutri1_id, @nutricionista_grupo_id);

-- ============================================
-- Dados de exemplo - Pratos
-- ============================================

-- Prato brasileiro vegano
SET @prato1_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato1_id, 'Feijoada Vegana', 'vegano', 'brasileira', 'Feijoada preparada com proteína de soja e feijão preto', 350.00, 18.50, 45.00, 8.00, 1.50, 12.00, 650.00, 3.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato1_id, 'Feijão preto'),
(UUID(), @prato1_id, 'Proteína de soja'),
(UUID(), @prato1_id, 'Cebola'),
(UUID(), @prato1_id, 'Alho'),
(UUID(), @prato1_id, 'Louro'),
(UUID(), @prato1_id, 'Pimenta'),
(UUID(), @prato1_id, 'Óleo de girassol');

-- Prato francês vegetariano
SET @prato2_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato2_id, 'Ratatouille', 'vegetariano', 'francesa', 'Legumes provençais assados ao forno', 180.00, 4.50, 22.00, 9.00, 1.20, 6.50, 320.00, 8.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato2_id, 'Berinjela'),
(UUID(), @prato2_id, 'Abobrinha'),
(UUID(), @prato2_id, 'Tomate'),
(UUID(), @prato2_id, 'Pimentão'),
(UUID(), @prato2_id, 'Cebola'),
(UUID(), @prato2_id, 'Alho'),
(UUID(), @prato2_id, 'Azeite de oliva'),
(UUID(), @prato2_id, 'Ervas de provence');

-- Prato indiano vegano
SET @prato3_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato3_id, 'Chana Masala', 'vegano', 'indiana', 'Grão-de-bico ao curry com especiarias indianas', 290.00, 12.00, 38.00, 10.00, 1.80, 9.00, 580.00, 5.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato3_id, 'Grão-de-bico'),
(UUID(), @prato3_id, 'Tomate'),
(UUID(), @prato3_id, 'Cebola'),
(UUID(), @prato3_id, 'Gengibre'),
(UUID(), @prato3_id, 'Alho'),
(UUID(), @prato3_id, 'Curry em pó'),
(UUID(), @prato3_id, 'Cominho'),
(UUID(), @prato3_id, 'Coentro'),
(UUID(), @prato3_id, 'Óleo de coco');

-- Prato brasileiro onívoro
SET @prato4_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato4_id, 'Moqueca de Peixe', 'onivoro', 'brasileira', 'Moqueca capixaba com peixe e urucum', 420.00, 35.00, 18.00, 22.00, 12.00, 4.50, 720.00, 4.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato4_id, 'Peixe'),
(UUID(), @prato4_id, 'Leite de coco'),
(UUID(), @prato4_id, 'Tomate'),
(UUID(), @prato4_id, 'Cebola'),
(UUID(), @prato4_id, 'Pimentão'),
(UUID(), @prato4_id, 'Coentro'),
(UUID(), @prato4_id, 'Urucum'),
(UUID(), @prato4_id, 'Azeite de dendê');

-- ============================================
-- ORIGEM: BRASILEIRA (mais 4 pratos)
-- ============================================

-- Brasileira - Onívoro 1
SET @prato5_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato5_id, 'Picanha na Brasa', 'onivoro', 'brasileira', 'Picanha grelhada com alho e sal grosso', 380.00, 28.00, 0.00, 30.00, 12.00, 0.00, 580.00, 0.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato5_id, 'Picanha'),
(UUID(), @prato5_id, 'Alho'),
(UUID(), @prato5_id, 'Sal grosso');

-- Brasileira - Onívoro 2
SET @prato6_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato6_id, 'Bobó de Camarão', 'onivoro', 'brasileira', 'Camarão em molho cremoso de mandioca e leite de coco', 340.00, 22.00, 28.00, 16.00, 8.00, 3.50, 680.00, 3.50);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato6_id, 'Camarão'),
(UUID(), @prato6_id, 'Mandioca'),
(UUID(), @prato6_id, 'Leite de coco'),
(UUID(), @prato6_id, 'Azeite de dendê'),
(UUID(), @prato6_id, 'Cebola'),
(UUID(), @prato6_id, 'Tomate'),
(UUID(), @prato6_id, 'Coentro');

-- Brasileira - Vegetariano 1
SET @prato7_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato7_id, 'Pão de Queijo', 'vegetariano', 'brasileira', 'Tradicional pão de queijo mineiro', 280.00, 8.00, 35.00, 12.00, 6.00, 1.50, 420.00, 2.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato7_id, 'Polvilho azedo'),
(UUID(), @prato7_id, 'Queijo minas'),
(UUID(), @prato7_id, 'Leite'),
(UUID(), @prato7_id, 'Ovos'),
(UUID(), @prato7_id, 'Óleo'),
(UUID(), @prato7_id, 'Sal');

-- Brasileira - Vegetariano 2
SET @prato8_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato8_id, 'Acarajé', 'vegetariano', 'brasileira', 'Bolinho de feijão fradinho frito no azeite de dendê', 320.00, 10.00, 38.00, 14.00, 2.50, 8.00, 520.00, 2.50);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato8_id, 'Feijão fradinho'),
(UUID(), @prato8_id, 'Cebola'),
(UUID(), @prato8_id, 'Sal'),
(UUID(), @prato8_id, 'Azeite de dendê');

-- Brasileira - Vegano 1
SET @prato9_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato9_id, 'Açaí na Tigela', 'vegano', 'brasileira', 'Açaí batido com banana e granola', 420.00, 8.00, 68.00, 14.00, 3.00, 12.00, 20.00, 35.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato9_id, 'Polpa de açaí'),
(UUID(), @prato9_id, 'Banana'),
(UUID(), @prato9_id, 'Granola'),
(UUID(), @prato9_id, 'Morango'),
(UUID(), @prato9_id, 'Mel vegano');

-- ============================================
-- ORIGEM: FRANCESA (5 pratos)
-- ============================================

-- Francesa - Onívoro 1
SET @prato10_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato10_id, 'Coq au Vin', 'onivoro', 'francesa', 'Frango ao vinho tinto com cogumelos e bacon', 450.00, 32.00, 12.00, 28.00, 10.00, 2.50, 820.00, 4.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato10_id, 'Frango'),
(UUID(), @prato10_id, 'Vinho tinto'),
(UUID(), @prato10_id, 'Bacon'),
(UUID(), @prato10_id, 'Cogumelos'),
(UUID(), @prato10_id, 'Cebola'),
(UUID(), @prato10_id, 'Alho'),
(UUID(), @prato10_id, 'Tomilho');

-- Francesa - Onívoro 2
SET @prato11_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato11_id, 'Boeuf Bourguignon', 'onivoro', 'francesa', 'Carne bovina cozida no vinho tinto com legumes', 520.00, 38.00, 15.00, 32.00, 14.00, 3.00, 880.00, 5.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato11_id, 'Carne bovina'),
(UUID(), @prato11_id, 'Vinho tinto'),
(UUID(), @prato11_id, 'Cenoura'),
(UUID(), @prato11_id, 'Cebola'),
(UUID(), @prato11_id, 'Bacon'),
(UUID(), @prato11_id, 'Cogumelos'),
(UUID(), @prato11_id, 'Tomilho');

-- Francesa - Vegetariano 1
SET @prato12_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato12_id, 'Quiche Lorraine Vegetariana', 'vegetariano', 'francesa', 'Torta salgada com queijo e vegetais', 380.00, 14.00, 32.00, 22.00, 12.00, 2.50, 720.00, 4.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato12_id, 'Massa podre'),
(UUID(), @prato12_id, 'Ovos'),
(UUID(), @prato12_id, 'Creme de leite'),
(UUID(), @prato12_id, 'Queijo gruyère'),
(UUID(), @prato12_id, 'Espinafre'),
(UUID(), @prato12_id, 'Cebola');

-- Francesa - Vegetariano 2
SET @prato13_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato13_id, 'Soupe à l''Oignon', 'vegetariano', 'francesa', 'Sopa de cebola gratinada com queijo', 280.00, 12.00, 28.00, 14.00, 8.00, 3.50, 920.00, 8.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato13_id, 'Cebola'),
(UUID(), @prato13_id, 'Caldo de legumes'),
(UUID(), @prato13_id, 'Vinho branco'),
(UUID(), @prato13_id, 'Pão'),
(UUID(), @prato13_id, 'Queijo gruyère'),
(UUID(), @prato13_id, 'Manteiga');

-- Francesa - Vegano 1
SET @prato14_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato14_id, 'Salade Niçoise Vegana', 'vegano', 'francesa', 'Salada provençal com tomate, azeitona e batata', 220.00, 6.00, 32.00, 8.00, 1.00, 7.00, 520.00, 6.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato14_id, 'Tomate'),
(UUID(), @prato14_id, 'Batata'),
(UUID(), @prato14_id, 'Vagem'),
(UUID(), @prato14_id, 'Azeitona'),
(UUID(), @prato14_id, 'Alface'),
(UUID(), @prato14_id, 'Azeite de oliva'),
(UUID(), @prato14_id, 'Alcaparras');

-- ============================================
-- ORIGEM: INDIANA (5 pratos)
-- ============================================

-- Indiana - Onívoro 1
SET @prato15_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato15_id, 'Chicken Tikka Masala', 'onivoro', 'indiana', 'Frango marinado em especiarias com molho cremoso', 420.00, 28.00, 22.00, 24.00, 12.00, 3.50, 780.00, 6.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato15_id, 'Frango'),
(UUID(), @prato15_id, 'Iogurte'),
(UUID(), @prato15_id, 'Tomate'),
(UUID(), @prato15_id, 'Creme de leite'),
(UUID(), @prato15_id, 'Garam masala'),
(UUID(), @prato15_id, 'Gengibre'),
(UUID(), @prato15_id, 'Alho');

-- Indiana - Onívoro 2
SET @prato16_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato16_id, 'Lamb Rogan Josh', 'onivoro', 'indiana', 'Cordeiro em molho aromático de curry vermelho', 480.00, 32.00, 18.00, 30.00, 14.00, 2.50, 820.00, 5.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato16_id, 'Cordeiro'),
(UUID(), @prato16_id, 'Iogurte'),
(UUID(), @prato16_id, 'Tomate'),
(UUID(), @prato16_id, 'Cebola'),
(UUID(), @prato16_id, 'Pimenta caxemira'),
(UUID(), @prato16_id, 'Cardamomo'),
(UUID(), @prato16_id, 'Gengibre');

-- Indiana - Vegetariano 1
SET @prato17_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato17_id, 'Palak Paneer', 'vegetariano', 'indiana', 'Queijo indiano em molho de espinafre', 320.00, 16.00, 18.00, 20.00, 10.00, 5.00, 680.00, 4.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato17_id, 'Paneer'),
(UUID(), @prato17_id, 'Espinafre'),
(UUID(), @prato17_id, 'Cebola'),
(UUID(), @prato17_id, 'Tomate'),
(UUID(), @prato17_id, 'Creme de leite'),
(UUID(), @prato17_id, 'Garam masala'),
(UUID(), @prato17_id, 'Gengibre');

-- Indiana - Vegetariano 2
SET @prato18_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato18_id, 'Aloo Gobi', 'vegetariano', 'indiana', 'Batata e couve-flor com especiarias indianas', 240.00, 6.00, 38.00, 8.00, 1.00, 7.00, 520.00, 5.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato18_id, 'Batata'),
(UUID(), @prato18_id, 'Couve-flor'),
(UUID(), @prato18_id, 'Cebola'),
(UUID(), @prato18_id, 'Tomate'),
(UUID(), @prato18_id, 'Cúrcuma'),
(UUID(), @prato18_id, 'Cominho'),
(UUID(), @prato18_id, 'Gengibre');

-- Indiana - Vegano 1
SET @prato19_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato19_id, 'Dal Tadka', 'vegano', 'indiana', 'Lentilhas temperadas com especiarias aromáticas', 260.00, 14.00, 42.00, 4.00, 0.50, 10.00, 580.00, 3.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato19_id, 'Lentilha'),
(UUID(), @prato19_id, 'Tomate'),
(UUID(), @prato19_id, 'Cebola'),
(UUID(), @prato19_id, 'Alho'),
(UUID(), @prato19_id, 'Cominho'),
(UUID(), @prato19_id, 'Cúrcuma'),
(UUID(), @prato19_id, 'Coentro');

-- ============================================
-- ORIGEM: ITALIANA (5 pratos)
-- ============================================

-- Italiana - Onívoro 1
SET @prato20_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato20_id, 'Carbonara', 'onivoro', 'italiana', 'Massa com molho cremoso de ovos, queijo e bacon', 520.00, 22.00, 58.00, 22.00, 10.00, 3.00, 820.00, 3.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato20_id, 'Spaghetti'),
(UUID(), @prato20_id, 'Bacon'),
(UUID(), @prato20_id, 'Ovos'),
(UUID(), @prato20_id, 'Queijo pecorino'),
(UUID(), @prato20_id, 'Pimenta preta');

-- Italiana - Onívoro 2
SET @prato21_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato21_id, 'Osso Buco', 'onivoro', 'italiana', 'Jarrete de vitela cozido lentamente com legumes', 460.00, 35.00, 15.00, 28.00, 10.00, 3.50, 750.00, 5.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato21_id, 'Jarrete de vitela'),
(UUID(), @prato21_id, 'Vinho branco'),
(UUID(), @prato21_id, 'Tomate'),
(UUID(), @prato21_id, 'Cenoura'),
(UUID(), @prato21_id, 'Cebola'),
(UUID(), @prato21_id, 'Salsão'),
(UUID(), @prato21_id, 'Alho');

-- Italiana - Vegetariano 1
SET @prato22_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato22_id, 'Margherita Pizza', 'vegetariano', 'italiana', 'Pizza clássica com molho de tomate, mozzarella e manjericão', 280.00, 12.00, 36.00, 10.00, 5.00, 2.50, 620.00, 4.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato22_id, 'Massa de pizza'),
(UUID(), @prato22_id, 'Molho de tomate'),
(UUID(), @prato22_id, 'Mozzarella'),
(UUID(), @prato22_id, 'Manjericão'),
(UUID(), @prato22_id, 'Azeite de oliva');

-- Italiana - Vegetariano 2
SET @prato23_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato23_id, 'Risotto ai Funghi', 'vegetariano', 'italiana', 'Risoto cremoso com cogumelos porcini', 380.00, 10.00, 52.00, 14.00, 6.00, 2.50, 680.00, 2.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato23_id, 'Arroz arbório'),
(UUID(), @prato23_id, 'Cogumelos porcini'),
(UUID(), @prato23_id, 'Vinho branco'),
(UUID(), @prato23_id, 'Caldo de legumes'),
(UUID(), @prato23_id, 'Queijo parmesão'),
(UUID(), @prato23_id, 'Manteiga'),
(UUID(), @prato23_id, 'Cebola');

-- Italiana - Vegano 1
SET @prato24_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato24_id, 'Pasta al Pomodoro', 'vegano', 'italiana', 'Massa com molho simples de tomate fresco e manjericão', 320.00, 10.00, 58.00, 6.00, 0.80, 5.00, 420.00, 6.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato24_id, 'Spaghetti'),
(UUID(), @prato24_id, 'Tomate'),
(UUID(), @prato24_id, 'Alho'),
(UUID(), @prato24_id, 'Manjericão'),
(UUID(), @prato24_id, 'Azeite de oliva');

-- ============================================
-- ORIGEM: JAPONESA (5 pratos)
-- ============================================

-- Japonesa - Onívoro 1
SET @prato25_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato25_id, 'Sushi Variado', 'onivoro', 'japonesa', 'Combinação de sushi com salmão, atum e peixe branco', 320.00, 18.00, 48.00, 6.00, 1.20, 2.00, 680.00, 8.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato25_id, 'Arroz japonês'),
(UUID(), @prato25_id, 'Salmão'),
(UUID(), @prato25_id, 'Atum'),
(UUID(), @prato25_id, 'Peixe branco'),
(UUID(), @prato25_id, 'Nori'),
(UUID(), @prato25_id, 'Vinagre de arroz'),
(UUID(), @prato25_id, 'Wasabi');

-- Japonesa - Onívoro 2
SET @prato26_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato26_id, 'Tonkatsu', 'onivoro', 'japonesa', 'Porco empanado e frito, servido com molho especial', 480.00, 28.00, 42.00, 22.00, 5.00, 2.50, 820.00, 6.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato26_id, 'Lombo de porco'),
(UUID(), @prato26_id, 'Farinha panko'),
(UUID(), @prato26_id, 'Ovo'),
(UUID(), @prato26_id, 'Farinha de trigo'),
(UUID(), @prato26_id, 'Molho tonkatsu'),
(UUID(), @prato26_id, 'Repolho');

-- Japonesa - Vegetariano 1
SET @prato27_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato27_id, 'Tempura de Legumes', 'vegetariano', 'japonesa', 'Legumes empanados em massa leve e fritos', 280.00, 6.00, 38.00, 12.00, 2.00, 4.50, 480.00, 3.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato27_id, 'Batata-doce'),
(UUID(), @prato27_id, 'Berinjela'),
(UUID(), @prato27_id, 'Abóbora'),
(UUID(), @prato27_id, 'Farinha de trigo'),
(UUID(), @prato27_id, 'Água gelada'),
(UUID(), @prato27_id, 'Óleo para fritura');

-- Japonesa - Vegetariano 2
SET @prato28_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato28_id, 'Yakisoba Vegetariano', 'vegetariano', 'japonesa', 'Macarrão salteado com legumes e molho especial', 340.00, 10.00, 52.00, 10.00, 1.50, 5.00, 920.00, 8.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato28_id, 'Macarrão yakisoba'),
(UUID(), @prato28_id, 'Repolho'),
(UUID(), @prato28_id, 'Cenoura'),
(UUID(), @prato28_id, 'Brócolis'),
(UUID(), @prato28_id, 'Molho shoyu'),
(UUID(), @prato28_id, 'Gengibre'),
(UUID(), @prato28_id, 'Alho');

-- Japonesa - Vegano 1
SET @prato29_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato29_id, 'Miso Soup', 'vegano', 'japonesa', 'Sopa tradicional de missô com tofu e algas', 80.00, 6.00, 8.00, 2.50, 0.30, 2.00, 820.00, 2.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato29_id, 'Missô'),
(UUID(), @prato29_id, 'Tofu'),
(UUID(), @prato29_id, 'Alga wakame'),
(UUID(), @prato29_id, 'Cebolinha'),
(UUID(), @prato29_id, 'Dashi vegano');

-- ============================================
-- ORIGEM: MEXICANA (5 pratos)
-- ============================================

-- Mexicana - Onívoro 1
SET @prato30_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato30_id, 'Tacos al Pastor', 'onivoro', 'mexicana', 'Tacos com carne de porco marinada e abacaxi', 380.00, 22.00, 42.00, 14.00, 4.00, 5.00, 720.00, 6.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato30_id, 'Carne de porco'),
(UUID(), @prato30_id, 'Abacaxi'),
(UUID(), @prato30_id, 'Tortilla de milho'),
(UUID(), @prato30_id, 'Cebola'),
(UUID(), @prato30_id, 'Coentro'),
(UUID(), @prato30_id, 'Pimenta chipotle'),
(UUID(), @prato30_id, 'Limão');

-- Mexicana - Onívoro 2
SET @prato31_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato31_id, 'Enchiladas de Pollo', 'onivoro', 'mexicana', 'Tortilhas recheadas com frango e cobertas com molho', 420.00, 26.00, 38.00, 18.00, 8.00, 5.50, 880.00, 5.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato31_id, 'Frango'),
(UUID(), @prato31_id, 'Tortilla de milho'),
(UUID(), @prato31_id, 'Molho de tomate'),
(UUID(), @prato31_id, 'Queijo'),
(UUID(), @prato31_id, 'Cebola'),
(UUID(), @prato31_id, 'Pimenta'),
(UUID(), @prato31_id, 'Creme de leite');

-- Mexicana - Vegetariano 1
SET @prato32_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato32_id, 'Quesadillas de Queijo', 'vegetariano', 'mexicana', 'Tortilhas grelhadas recheadas com queijo derretido', 360.00, 16.00, 38.00, 16.00, 8.00, 3.00, 720.00, 2.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato32_id, 'Tortilla de farinha'),
(UUID(), @prato32_id, 'Queijo oaxaca'),
(UUID(), @prato32_id, 'Pimentão'),
(UUID(), @prato32_id, 'Cebola'),
(UUID(), @prato32_id, 'Manteiga');

-- Mexicana - Vegetariano 2
SET @prato33_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato33_id, 'Chiles Rellenos', 'vegetariano', 'mexicana', 'Pimentões recheados com queijo e empanados', 340.00, 14.00, 32.00, 18.00, 8.00, 4.00, 680.00, 5.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato33_id, 'Pimentão poblano'),
(UUID(), @prato33_id, 'Queijo'),
(UUID(), @prato33_id, 'Ovo'),
(UUID(), @prato33_id, 'Farinha'),
(UUID(), @prato33_id, 'Molho de tomate');

-- Mexicana - Vegano 1
SET @prato34_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato34_id, 'Guacamole com Nachos', 'vegano', 'mexicana', 'Pasta cremosa de abacate com tortilhas crocantes', 280.00, 5.00, 32.00, 16.00, 2.50, 8.00, 520.00, 2.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato34_id, 'Abacate'),
(UUID(), @prato34_id, 'Tomate'),
(UUID(), @prato34_id, 'Cebola'),
(UUID(), @prato34_id, 'Coentro'),
(UUID(), @prato34_id, 'Limão'),
(UUID(), @prato34_id, 'Tortilla chips');

-- ============================================
-- ORIGEM: TAILANDESA (5 pratos)
-- ============================================

-- Tailandesa - Onívoro 1
SET @prato35_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato35_id, 'Pad Thai com Camarão', 'onivoro', 'tailandesa', 'Macarrão de arroz salteado com camarão e amendoim', 420.00, 24.00, 52.00, 14.00, 2.50, 3.50, 920.00, 12.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato35_id, 'Macarrão de arroz'),
(UUID(), @prato35_id, 'Camarão'),
(UUID(), @prato35_id, 'Ovo'),
(UUID(), @prato35_id, 'Amendoim'),
(UUID(), @prato35_id, 'Molho de tamarindo'),
(UUID(), @prato35_id, 'Broto de feijão'),
(UUID(), @prato35_id, 'Limão');

-- Tailandesa - Onívoro 2
SET @prato36_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato36_id, 'Green Curry com Frango', 'onivoro', 'tailandesa', 'Curry verde tailandês com frango e legumes', 380.00, 26.00, 22.00, 22.00, 14.00, 3.00, 820.00, 6.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato36_id, 'Frango'),
(UUID(), @prato36_id, 'Leite de coco'),
(UUID(), @prato36_id, 'Curry verde'),
(UUID(), @prato36_id, 'Berinjela'),
(UUID(), @prato36_id, 'Pimentão'),
(UUID(), @prato36_id, 'Manjericão tailandês'),
(UUID(), @prato36_id, 'Molho de peixe');

-- Tailandesa - Vegetariano 1
SET @prato37_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato37_id, 'Pad See Ew Vegetariano', 'vegetariano', 'tailandesa', 'Macarrão largo salteado com legumes e molho de soja', 340.00, 10.00, 56.00, 8.00, 1.20, 4.00, 880.00, 8.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato37_id, 'Macarrão de arroz largo'),
(UUID(), @prato37_id, 'Brócolis'),
(UUID(), @prato37_id, 'Ovo'),
(UUID(), @prato37_id, 'Molho de soja escuro'),
(UUID(), @prato37_id, 'Alho'),
(UUID(), @prato37_id, 'Molho de ostra vegetariano');

-- Tailandesa - Vegetariano 2
SET @prato38_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato38_id, 'Som Tam', 'vegetariano', 'tailandesa', 'Salada picante de mamão verde', 160.00, 4.00, 28.00, 4.00, 0.50, 6.00, 720.00, 14.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato38_id, 'Mamão verde'),
(UUID(), @prato38_id, 'Tomate cereja'),
(UUID(), @prato38_id, 'Amendoim'),
(UUID(), @prato38_id, 'Pimenta'),
(UUID(), @prato38_id, 'Alho'),
(UUID(), @prato38_id, 'Limão'),
(UUID(), @prato38_id, 'Molho de peixe vegetariano');

-- Tailandesa - Vegano 1
SET @prato39_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato39_id, 'Tom Yum Vegano', 'vegano', 'tailandesa', 'Sopa picante e azeda com cogumelos e capim-limão', 120.00, 4.00, 18.00, 3.00, 0.50, 4.00, 820.00, 6.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato39_id, 'Cogumelos'),
(UUID(), @prato39_id, 'Tomate'),
(UUID(), @prato39_id, 'Capim-limão'),
(UUID(), @prato39_id, 'Galanga'),
(UUID(), @prato39_id, 'Folhas de lima kaffir'),
(UUID(), @prato39_id, 'Pimenta tailandesa'),
(UUID(), @prato39_id, 'Coentro');

-- ============================================
-- ORIGEM: CHINESA (5 pratos)
-- ============================================

-- Chinesa - Onívoro 1
SET @prato40_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato40_id, 'Pato de Pequim', 'onivoro', 'chinesa', 'Pato assado crocante servido com panquecas', 480.00, 28.00, 32.00, 26.00, 8.00, 2.00, 920.00, 8.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato40_id, 'Pato'),
(UUID(), @prato40_id, 'Panquecas chinesas'),
(UUID(), @prato40_id, 'Molho hoisin'),
(UUID(), @prato40_id, 'Pepino'),
(UUID(), @prato40_id, 'Cebolinha'),
(UUID(), @prato40_id, 'Mel');

-- Chinesa - Onívoro 2
SET @prato41_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato41_id, 'Kung Pao Chicken', 'onivoro', 'chinesa', 'Frango salteado com amendoim e pimentas', 420.00, 30.00, 28.00, 20.00, 3.00, 4.00, 980.00, 10.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato41_id, 'Frango'),
(UUID(), @prato41_id, 'Amendoim'),
(UUID(), @prato41_id, 'Pimenta seca'),
(UUID(), @prato41_id, 'Pimentão'),
(UUID(), @prato41_id, 'Molho de soja'),
(UUID(), @prato41_id, 'Vinagre'),
(UUID(), @prato41_id, 'Gengibre');

-- Chinesa - Vegetariano 1
SET @prato42_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato42_id, 'Ma Po Tofu', 'vegetariano', 'chinesa', 'Tofu em molho picante de feijão fermentado', 280.00, 14.00, 18.00, 16.00, 2.50, 3.50, 920.00, 4.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato42_id, 'Tofu'),
(UUID(), @prato42_id, 'Pasta de feijão fermentado'),
(UUID(), @prato42_id, 'Pimenta sichuam'),
(UUID(), @prato42_id, 'Alho'),
(UUID(), @prato42_id, 'Gengibre'),
(UUID(), @prato42_id, 'Cebolinha'),
(UUID(), @prato42_id, 'Molho de soja');

-- Chinesa - Vegetariano 2
SET @prato43_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato43_id, 'Chow Mein Vegetariano', 'vegetariano', 'chinesa', 'Macarrão frito com legumes variados', 360.00, 10.00, 52.00, 12.00, 2.00, 5.00, 880.00, 6.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato43_id, 'Macarrão chinês'),
(UUID(), @prato43_id, 'Repolho'),
(UUID(), @prato43_id, 'Cenoura'),
(UUID(), @prato43_id, 'Brócolis'),
(UUID(), @prato43_id, 'Broto de bambu'),
(UUID(), @prato43_id, 'Molho de soja'),
(UUID(), @prato43_id, 'Óleo de gergelim');

-- Chinesa - Vegano 1
SET @prato44_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato44_id, 'Bok Choy Salteado', 'vegano', 'chinesa', 'Couve chinesa salteada com alho e gengibre', 80.00, 3.00, 8.00, 4.00, 0.50, 3.00, 520.00, 2.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato44_id, 'Bok choy'),
(UUID(), @prato44_id, 'Alho'),
(UUID(), @prato44_id, 'Gengibre'),
(UUID(), @prato44_id, 'Molho de soja'),
(UUID(), @prato44_id, 'Óleo de gergelim');

-- ============================================
-- ORIGEM: AMERICANA (5 pratos)
-- ============================================

-- Americana - Onívoro 1
SET @prato45_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato45_id, 'Classic Cheeseburger', 'onivoro', 'americana', 'Hambúrguer tradicional com queijo e condimentos', 580.00, 32.00, 42.00, 30.00, 14.00, 3.00, 920.00, 8.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato45_id, 'Carne bovina moída'),
(UUID(), @prato45_id, 'Pão de hambúrguer'),
(UUID(), @prato45_id, 'Queijo cheddar'),
(UUID(), @prato45_id, 'Alface'),
(UUID(), @prato45_id, 'Tomate'),
(UUID(), @prato45_id, 'Cebola'),
(UUID(), @prato45_id, 'Picles');

-- Americana - Onívoro 2
SET @prato46_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato46_id, 'BBQ Ribs', 'onivoro', 'americana', 'Costela suína ao molho barbecue', 620.00, 38.00, 32.00, 38.00, 16.00, 2.00, 1120.00, 24.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato46_id, 'Costela de porco'),
(UUID(), @prato46_id, 'Molho barbecue'),
(UUID(), @prato46_id, 'Mel'),
(UUID(), @prato46_id, 'Vinagre'),
(UUID(), @prato46_id, 'Páprica'),
(UUID(), @prato46_id, 'Alho em pó');

-- Americana - Vegetariano 1
SET @prato47_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato47_id, 'Mac and Cheese', 'vegetariano', 'americana', 'Macarrão com queijo cremoso gratinado', 480.00, 18.00, 52.00, 22.00, 14.00, 2.50, 820.00, 4.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato47_id, 'Macarrão cotovelo'),
(UUID(), @prato47_id, 'Queijo cheddar'),
(UUID(), @prato47_id, 'Leite'),
(UUID(), @prato47_id, 'Manteiga'),
(UUID(), @prato47_id, 'Farinha'),
(UUID(), @prato47_id, 'Pão ralado');

-- Americana - Vegetariano 2
SET @prato48_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato48_id, 'Grilled Cheese Sandwich', 'vegetariano', 'americana', 'Sanduíche de queijo grelhado crocante', 380.00, 14.00, 38.00, 18.00, 10.00, 2.00, 720.00, 4.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato48_id, 'Pão de forma'),
(UUID(), @prato48_id, 'Queijo cheddar'),
(UUID(), @prato48_id, 'Manteiga');

-- Americana - Vegano 1
SET @prato49_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato49_id, 'California Salad', 'vegano', 'americana', 'Salada californiana com abacate e nozes', 280.00, 6.00, 22.00, 20.00, 2.50, 8.00, 320.00, 6.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato49_id, 'Mix de folhas'),
(UUID(), @prato49_id, 'Abacate'),
(UUID(), @prato49_id, 'Nozes'),
(UUID(), @prato49_id, 'Tomate cereja'),
(UUID(), @prato49_id, 'Pepino'),
(UUID(), @prato49_id, 'Azeite de oliva'),
(UUID(), @prato49_id, 'Limão');

-- ============================================
-- ORIGEM: OUTRA (5 pratos - mistura global)
-- ============================================

-- Outra - Onívoro 1 (Grego)
SET @prato50_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato50_id, 'Moussaka', 'onivoro', 'outra', 'Lasanha grega com berinjela e carne moída', 420.00, 24.00, 28.00, 24.00, 12.00, 5.00, 820.00, 8.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato50_id, 'Carne bovina moída'),
(UUID(), @prato50_id, 'Berinjela'),
(UUID(), @prato50_id, 'Molho bechamel'),
(UUID(), @prato50_id, 'Tomate'),
(UUID(), @prato50_id, 'Cebola'),
(UUID(), @prato50_id, 'Canela'),
(UUID(), @prato50_id, 'Queijo');

-- Outra - Onívoro 2 (Marroquino)
SET @prato51_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato51_id, 'Tagine de Cordeiro', 'onivoro', 'outra', 'Ensopado marroquino de cordeiro com damascos', 460.00, 32.00, 38.00, 20.00, 7.00, 6.00, 780.00, 18.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato51_id, 'Cordeiro'),
(UUID(), @prato51_id, 'Damasco seco'),
(UUID(), @prato51_id, 'Grão-de-bico'),
(UUID(), @prato51_id, 'Cebola'),
(UUID(), @prato51_id, 'Canela'),
(UUID(), @prato51_id, 'Cominho'),
(UUID(), @prato51_id, 'Coentro');

-- Outra - Vegetariano 1 (Grego)
SET @prato52_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato52_id, 'Spanakopita', 'vegetariano', 'outra', 'Torta grega de espinafre e queijo feta', 320.00, 12.00, 28.00, 18.00, 8.00, 4.00, 720.00, 3.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato52_id, 'Massa filo'),
(UUID(), @prato52_id, 'Espinafre'),
(UUID(), @prato52_id, 'Queijo feta'),
(UUID(), @prato52_id, 'Cebola'),
(UUID(), @prato52_id, 'Ovos'),
(UUID(), @prato52_id, 'Azeite de oliva'),
(UUID(), @prato52_id, 'Endro');

-- Outra - Vegetariano 2 (Turco)
SET @prato53_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato53_id, 'Meze Turco', 'vegetariano', 'outra', 'Seleção de aperitivos turcos com homus e babaganoush', 280.00, 8.00, 32.00, 14.00, 2.00, 8.00, 620.00, 4.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato53_id, 'Grão-de-bico'),
(UUID(), @prato53_id, 'Berinjela'),
(UUID(), @prato53_id, 'Tahine'),
(UUID(), @prato53_id, 'Alho'),
(UUID(), @prato53_id, 'Limão'),
(UUID(), @prato53_id, 'Azeite de oliva'),
(UUID(), @prato53_id, 'Pão pita');

-- Outra - Vegano 1 (Mediterrâneo)
SET @prato54_id = UUID();
INSERT INTO prato (id, nome, tipo, origem, descricao, calorias, proteinas, carboidratos, gorduras, gorduras_saturadas, fibras, sodio, acucares) 
VALUES (@prato54_id, 'Falafel', 'vegano', 'outra', 'Bolinhos de grão-de-bico fritos e temperados', 320.00, 12.00, 42.00, 12.00, 1.50, 10.00, 680.00, 4.00);

INSERT INTO ingrediente (id, prato_id, nome) VALUES
(UUID(), @prato54_id, 'Grão-de-bico'),
(UUID(), @prato54_id, 'Cebola'),
(UUID(), @prato54_id, 'Alho'),
(UUID(), @prato54_id, 'Salsinha'),
(UUID(), @prato54_id, 'Coentro'),
(UUID(), @prato54_id, 'Cominho'),
(UUID(), @prato54_id, 'Farinha de grão-de-bico');

-- ============================================
-- Comentários finais
-- ============================================

-- Este arquivo contém:
-- 1. Dados iniciais dos grupos da aplicação
-- 2. Usuário administrador padrão (comentado)
-- 3. Exemplos de pratos com ingredientes e tabela nutricional

-- Para executar este arquivo, primeiro execute o schema.sql:
-- mysql -u root -p < schema.sql
-- mysql -u root -p < dados.sql

