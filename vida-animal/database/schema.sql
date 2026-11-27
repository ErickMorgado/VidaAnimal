SET NAMES utf8mb4;

DROP DATABASE IF EXISTS vida_animal;
CREATE DATABASE vida_animal
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE vida_animal;

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ativo BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE = InnoDB;

CREATE TABLE doador (
    id_doador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE,
    telefone VARCHAR(20),
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ativo BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE = InnoDB;

CREATE TABLE doacao (
    id_doacao INT AUTO_INCREMENT PRIMARY KEY,
    id_doador INT NOT NULL,
    data_doacao DATE NOT NULL,
    valor DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    descricao TEXT,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_doacao_valor_nao_negativo CHECK (valor >= 0),
    CONSTRAINT fk_doacao_doador
        FOREIGN KEY (id_doador) REFERENCES doador (id_doador)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE TABLE animal_tipo (
    id_animal_tipo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL UNIQUE,
    descricao VARCHAR(255),
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ativo BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE = InnoDB;

CREATE TABLE animal_raca (
    id_animal_raca INT AUTO_INCREMENT PRIMARY KEY,
    id_animal_tipo INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT uq_animal_raca_tipo_nome UNIQUE (id_animal_tipo, nome),
    CONSTRAINT uq_animal_raca_id_tipo UNIQUE (id_animal_raca, id_animal_tipo),
    CONSTRAINT fk_animal_raca_tipo
        FOREIGN KEY (id_animal_tipo) REFERENCES animal_tipo (id_animal_tipo)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE TABLE animal (
    id_animal INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    id_animal_tipo INT NOT NULL,
    id_animal_raca INT,
    descricao TEXT,
    data_entrada DATE NOT NULL,
    data_saida DATE,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT chk_animal_datas CHECK (data_saida IS NULL OR data_saida >= data_entrada),
    CONSTRAINT fk_animal_tipo
        FOREIGN KEY (id_animal_tipo) REFERENCES animal_tipo (id_animal_tipo)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_animal_raca_tipo_animal
        FOREIGN KEY (id_animal_raca, id_animal_tipo)
        REFERENCES animal_raca (id_animal_raca, id_animal_tipo)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE TABLE apadrinhamento (
    id_doador INT NOT NULL,
    id_animal INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (id_doador, id_animal),
    CONSTRAINT chk_apadrinhamento_datas
        CHECK (data_fim IS NULL OR data_fim >= data_inicio),
    CONSTRAINT fk_apadrinhamento_doador
        FOREIGN KEY (id_doador) REFERENCES doador (id_doador)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_apadrinhamento_animal
        FOREIGN KEY (id_animal) REFERENCES animal (id_animal)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE = InnoDB;