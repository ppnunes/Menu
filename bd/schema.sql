-- ============================================
-- Schema do Projeto Menu - Catálogo de Pratos
-- DDL - Data Definition Language
-- ============================================

-- Remover banco de dados se existir
DROP DATABASE IF EXISTS menu_db;

-- Criar banco de dados
CREATE DATABASE menu_db;

USE menu_db;

-- ============================================
-- Tabela: usuario
-- ============================================
CREATE TABLE usuario (
    id CHAR(36) PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_usuario_email (email),
    INDEX idx_usuario_ativo (ativo)
) ENGINE=InnoDB;

-- ============================================
-- Tabela: grupo (roles)
-- ============================================
CREATE TABLE grupo (
    id CHAR(36) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_grupo_nome (nome)
) ENGINE=InnoDB;

-- ============================================
-- Tabela: grupo_usuario (relacionamento N:N)
-- ============================================
CREATE TABLE grupo_usuario (
    id CHAR(36) PRIMARY KEY,
    usuario_id CHAR(36) NOT NULL,
    grupo_id CHAR(36) NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (grupo_id) REFERENCES grupo(id) ON DELETE CASCADE,
    UNIQUE KEY unique_usuario_grupo (usuario_id, grupo_id),
    INDEX idx_grupo_usuario_usuario (usuario_id),
    INDEX idx_grupo_usuario_grupo (grupo_id)
) ENGINE=InnoDB;

-- ============================================
-- Tabela: prato
-- ============================================
CREATE TABLE prato (
    id CHAR(36) PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    tipo ENUM('vegano', 'vegetariano', 'onivoro') NOT NULL,
    origem ENUM('brasileira', 'francesa', 'indiana', 'italiana', 'japonesa', 'mexicana', 'tailandesa', 'chinesa', 'americana', 'outra') NOT NULL,
    descricao TEXT,
    
    -- Tabela nutricional
    calorias DECIMAL(8, 2),
    proteinas DECIMAL(8, 2),
    carboidratos DECIMAL(8, 2),
    gorduras DECIMAL(8, 2),
    gorduras_saturadas DECIMAL(8, 2),
    fibras DECIMAL(8, 2),
    sodio DECIMAL(8, 2),
    acucares DECIMAL(8, 2),
    
    ativo BOOLEAN DEFAULT TRUE,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_prato_tipo (tipo),
    INDEX idx_prato_origem (origem),
    INDEX idx_prato_tipo_origem (tipo, origem),
    INDEX idx_prato_ativo (ativo),
    INDEX idx_prato_nome (nome)
) ENGINE=InnoDB;

-- ============================================
-- Tabela: ingrediente
-- ============================================
CREATE TABLE ingrediente (
    id CHAR(36) PRIMARY KEY,
    prato_id CHAR(36) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (prato_id) REFERENCES prato(id) ON DELETE CASCADE,
    INDEX idx_ingrediente_prato (prato_id),
    INDEX idx_ingrediente_nome (nome)
) ENGINE=InnoDB;

-- ============================================
-- FUNÇÕES
-- ============================================

DELIMITER //

-- Função para retornar timestamp atual
CREATE FUNCTION get_current_timestamp()
RETURNS TIMESTAMP
DETERMINISTIC
NO SQL
BEGIN
    RETURN CURRENT_TIMESTAMP;
END//

-- Função para verificar se um prato é low carb
-- Considera low carb se tiver menos de 20g de carboidratos
CREATE FUNCTION eh_low_carb(p_prato_id CHAR(36))
RETURNS BOOLEAN
READS SQL DATA
BEGIN
    DECLARE carbs DECIMAL(8,2);
    SELECT carboidratos INTO carbs
    FROM prato
    WHERE id = p_prato_id;
    
    -- Retorna TRUE se carboidratos < 20g
    RETURN carbs < 20.0;
END//

-- ============================================
-- PROCEDURES
-- ============================================

-- Procedure para ativar/desativar prato (toggle)
CREATE PROCEDURE toggle_status_prato(
    IN p_prato_id CHAR(36)
)
BEGIN
    UPDATE prato
    SET ativo = NOT ativo
    WHERE id = p_prato_id;
END//

-- ============================================
-- TRIGGERS para geração automática de UUID
-- ============================================

-- Trigger para usuario
CREATE TRIGGER before_insert_usuario
BEFORE INSERT ON usuario
FOR EACH ROW
BEGIN
    IF NEW.id IS NULL OR NEW.id = '' THEN
        SET NEW.id = UUID();
    END IF;
END//

-- Trigger para grupo
CREATE TRIGGER before_insert_grupo
BEFORE INSERT ON grupo
FOR EACH ROW
BEGIN
    IF NEW.id IS NULL OR NEW.id = '' THEN
        SET NEW.id = UUID();
    END IF;
END//

-- Trigger para grupo_usuario
CREATE TRIGGER before_insert_grupo_usuario
BEFORE INSERT ON grupo_usuario
FOR EACH ROW
BEGIN
    IF NEW.id IS NULL OR NEW.id = '' THEN
        SET NEW.id = UUID();
    END IF;
END//

-- Trigger para prato
CREATE TRIGGER before_insert_prato
BEFORE INSERT ON prato
FOR EACH ROW
BEGIN
    IF NEW.id IS NULL OR NEW.id = '' THEN
        SET NEW.id = UUID();
    END IF;
END//

-- Trigger para ingrediente
CREATE TRIGGER before_insert_ingrediente
BEFORE INSERT ON ingrediente
FOR EACH ROW
BEGIN
    IF NEW.id IS NULL OR NEW.id = '' THEN
        SET NEW.id = UUID();
    END IF;
END//

-- ============================================
-- TRIGGERS para atualização de timestamp
-- ============================================

-- Trigger para atualizar prato.atualizado_em
CREATE TRIGGER before_update_prato
BEFORE UPDATE ON prato
FOR EACH ROW
BEGIN
    SET NEW.atualizado_em = get_current_timestamp();
END//

-- Trigger para atualizar prato quando ingrediente é inserido
CREATE TRIGGER after_insert_ingrediente
AFTER INSERT ON ingrediente
FOR EACH ROW
BEGIN
    UPDATE prato 
    SET atualizado_em = get_current_timestamp() 
    WHERE id = NEW.prato_id;
END//

-- Trigger para atualizar prato quando ingrediente é atualizado
CREATE TRIGGER after_update_ingrediente
AFTER UPDATE ON ingrediente
FOR EACH ROW
BEGIN
    UPDATE prato 
    SET atualizado_em = get_current_timestamp() 
    WHERE id = NEW.prato_id;
END//

-- Trigger para atualizar prato quando ingrediente é deletado
CREATE TRIGGER after_delete_ingrediente
AFTER DELETE ON ingrediente
FOR EACH ROW
BEGIN
    UPDATE prato 
    SET atualizado_em = get_current_timestamp() 
    WHERE id = OLD.prato_id;
END//

DELIMITER ;

-- ============================================
-- VIEWS para usuário_comum
-- ============================================

-- View de pratos veganos
CREATE VIEW view_pratos_veganos AS
SELECT 
    p.id,
    p.nome,
    p.tipo,
    p.origem,
    p.descricao,
    p.calorias,
    p.proteinas,
    p.carboidratos,
    p.gorduras,
    p.gorduras_saturadas,
    p.fibras,
    p.sodio,
    p.acucares
FROM prato p
WHERE p.tipo = 'vegano' AND p.ativo = TRUE;

-- View de pratos vegetarianos
CREATE VIEW view_pratos_vegetarianos AS
SELECT 
    p.id,
    p.nome,
    p.tipo,
    p.origem,
    p.descricao,
    p.calorias,
    p.proteinas,
    p.carboidratos,
    p.gorduras,
    p.gorduras_saturadas,
    p.fibras,
    p.sodio,
    p.acucares
FROM prato p
WHERE p.tipo = 'vegetariano' AND p.ativo = TRUE;

-- View de pratos onívoros
CREATE VIEW view_pratos_onivoros AS
SELECT 
    p.id,
    p.nome,
    p.tipo,
    p.origem,
    p.descricao,
    p.calorias,
    p.proteinas,
    p.carboidratos,
    p.gorduras,
    p.gorduras_saturadas,
    p.fibras,
    p.sodio,
    p.acucares
FROM prato p
WHERE p.tipo = 'onivoro' AND p.ativo = TRUE;

-- View de pratos brasileiros
CREATE VIEW view_pratos_brasileiros AS
SELECT 
    p.id,
    p.nome,
    p.tipo,
    p.origem,
    p.descricao,
    p.calorias,
    p.proteinas,
    p.carboidratos,
    p.gorduras,
    p.gorduras_saturadas,
    p.fibras,
    p.sodio,
    p.acucares
FROM prato p
WHERE p.origem = 'brasileira' AND p.ativo = TRUE;

-- View de pratos franceses
CREATE VIEW view_pratos_franceses AS
SELECT 
    p.id,
    p.nome,
    p.tipo,
    p.origem,
    p.descricao,
    p.calorias,
    p.proteinas,
    p.carboidratos,
    p.gorduras,
    p.gorduras_saturadas,
    p.fibras,
    p.sodio,
    p.acucares
FROM prato p
WHERE p.origem = 'francesa' AND p.ativo = TRUE;

-- View de pratos indianos
CREATE VIEW view_pratos_indianos AS
SELECT 
    p.id,
    p.nome,
    p.tipo,
    p.origem,
    p.descricao,
    p.calorias,
    p.proteinas,
    p.carboidratos,
    p.gorduras,
    p.gorduras_saturadas,
    p.fibras,
    p.sodio,
    p.acucares
FROM prato p
WHERE p.origem = 'indiana' AND p.ativo = TRUE;

-- View completa de pratos com ingredientes
CREATE VIEW view_pratos_completos AS
SELECT 
    p.id,
    p.nome,
    p.tipo,
    p.origem,
    p.descricao,
    p.calorias,
    p.proteinas,
    p.carboidratos,
    p.gorduras,
    p.gorduras_saturadas,
    p.fibras,
    p.sodio,
    p.acucares,
    GROUP_CONCAT(i.nome SEPARATOR ', ') AS ingredientes
FROM prato p
LEFT JOIN ingrediente i ON p.id = i.prato_id
WHERE p.ativo = TRUE
GROUP BY p.id, p.nome, p.tipo, p.origem, p.descricao, 
         p.calorias, p.proteinas, p.carboidratos, p.gorduras,
         p.gorduras_saturadas, p.fibras, p.sodio, p.acucares;

-- ============================================
-- ROLES E PERMISSÕES DO MYSQL
-- ============================================

-- Role: Mantenedor (leitura e escrita em todo o schema)
CREATE ROLE IF NOT EXISTS 'role_mantenedor';
GRANT SELECT, INSERT, UPDATE, DELETE ON menu_db.* TO 'role_mantenedor';

-- Role: Qualidade (somente leitura de todo o schema)
CREATE ROLE IF NOT EXISTS 'role_qualidade';
GRANT SELECT ON menu_db.* TO 'role_qualidade';

-- ============================================
-- USERS DO MYSQL
-- ============================================

-- User: api_user (para ser usado pela API backend)
-- Senha: api_senha_123 (deve ser alterada em produção)
CREATE USER IF NOT EXISTS 'api_user'@'%' IDENTIFIED BY 'api_senha_123';
GRANT 'role_mantenedor' TO 'api_user'@'%';
SET DEFAULT ROLE 'role_mantenedor' TO 'api_user'@'%';

-- User: testador (para testes e QA)
-- Senha: testador_senha_123 (deve ser alterada em produção)
CREATE USER IF NOT EXISTS 'testador'@'%' IDENTIFIED BY 'testador_senha_123';
GRANT 'role_qualidade' TO 'testador'@'%';
SET DEFAULT ROLE 'role_qualidade' TO 'testador'@'%';

-- Aplicar as mudanças sem precisar reiniciar o banco
FLUSH PRIVILEGES;

-- ============================================
-- Comentários finais
-- ============================================

-- Este schema inclui:
-- 1. Definição de todas as tabelas (usuario, grupo, grupo_usuario, prato, ingrediente)
-- 2. Índices em campos importantes para otimização de consultas
-- 3. Funções:
--    - get_current_timestamp(): retorna timestamp atual
--    - eh_low_carb(): verifica se um prato tem menos de 20g de carboidratos
-- 4. Procedures:
--    - toggle_status_prato(): ativa/desativa um prato
-- 5. Triggers para geração automática de UUID
-- 6. Triggers para atualização de timestamps usando a função personalizada
-- 7. Triggers para atualizar prato.atualizado_em quando ingredientes são modificados
-- 8. Views filtradas por tipo e origem para usuário_comum
-- 9. Roles MySQL (role_mantenedor e role_qualidade)
-- 10. Users MySQL (api_user e testador) com suas respectivas roles
