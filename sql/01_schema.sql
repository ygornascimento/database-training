DROP TABLE IF EXISTS atribuicoes_ocorrencia;
DROP TABLE IF EXISTS historico_status_ocorrencia;
DROP TABLE IF EXISTS fotos_ocorrencia;
DROP TABLE IF EXISTS ocorrencias;
DROP TABLE IF EXISTS equipes;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS status_ocorrencia;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS bairros;

CREATE TABLE bairros (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE categorias (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE status_ocorrencia (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE usuarios (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE equipes (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(120) NOT NULL UNIQUE,
    ativa BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE ocorrencias (
    id BIGSERIAL PRIMARY KEY,
    protocolo VARCHAR(30) NOT NULL UNIQUE,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT NOT NULL,
    bairro_id BIGINT NOT NULL,
    categoria_id BIGINT NOT NULL,
    usuario_id BIGINT,
    latitude NUMERIC(10, 7),
    longitude NUMERIC(10, 7),
    criada_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_ocorrencias_bairros
        FOREIGN KEY (bairro_id) REFERENCES bairros(id),

    CONSTRAINT fk_ocorrencias_categorias
        FOREIGN KEY (categoria_id) REFERENCES categorias(id),

    CONSTRAINT fk_ocorrencias_usuarios
        FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE fotos_ocorrencia (
    id BIGSERIAL PRIMARY KEY,
    ocorrencia_id BIGINT NOT NULL,
    url TEXT NOT NULL,
    criada_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_fotos_ocorrencias
        FOREIGN KEY (ocorrencia_id) REFERENCES ocorrencias(id)
);

CREATE TABLE historico_status_ocorrencia (
    id BIGSERIAL PRIMARY KEY,
    ocorrencia_id BIGINT NOT NULL,
    status_id BIGINT NOT NULL,
    observacao TEXT,
    alterado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_historico_ocorrencias
        FOREIGN KEY (ocorrencia_id) REFERENCES ocorrencias(id),

    CONSTRAINT fk_historico_status
        FOREIGN KEY (status_id) REFERENCES status_ocorrencia(id)
);

CREATE TABLE atribuicoes_ocorrencia (
    id BIGSERIAL PRIMARY KEY,
    ocorrencia_id BIGINT NOT NULL,
    equipe_id BIGINT NOT NULL,
    atribuida_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    encerrada_em TIMESTAMP,

    CONSTRAINT fk_atribuicoes_ocorrencias
        FOREIGN KEY (ocorrencia_id) REFERENCES ocorrencias(id),

    CONSTRAINT fk_atribuicoes_equipes
        FOREIGN KEY (equipe_id) REFERENCES equipes(id)
);