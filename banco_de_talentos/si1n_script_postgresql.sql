/*----------------------------------------------------------------------------*/
/* TRABALHO INTEGRADO: Design e Desenvolvimento de Banco de Dados             */
/*----------------------------------------------------------------------------*/
/* Participantes:                                                             */
/*                                                                            */
/* Ana Julia Firme                     - Matr.202307837                       */
/* Caíque Almeida Amaral               - Matr.202305874                       */
/* Eduardo Tonani Tavares              - Matr.202305773                       */ 
/* Elder Alexandre de Oliveira Chiconi - Matr.202307420                       */
/*----------------------------------------------------------------------------*/
/* Professor:                                                                 */
/*                                                                            */
/* Abrantes Araujo Silva Filho                                                */
/*----------------------------------------------------------------------------*/


-- !   Aviso: Este script PostgreSQL não contem comandos de criar ou apagar    !
-- !   bancos de dados, usuários, schemas entre outros.                        !
-- !   A única coisa presente são os comandos de criação de tabelas, e chaves  !
-- !   (PK, PFK, FK), constraints pertinentes e comentários.                   !


/*----------------------------------------------------------------------------*/
/* Criação das Tabelas:                                                       */
/*----------------------------------------------------------------------------*/


-- Criação da tabela "usuarios" junto a sua chave primária "user_id".


CREATE TABLE usuarios (
user_id                            NUMERIC(100) NOT NULL,
nome                               VARCHAR(100) NOT NULL,
senha                              VARCHAR(30) NOT NULL,
usuario_foto                       BYTEA NOT NULL,
CONSTRAINT user_id                 PRIMARY KEY (user_id)
);

-- Criação da tabela "telefones" junto a sua chave primária composta "cod_tel, user_id".

CREATE TABLE telefones (
cod_tel                            NUMERIC(100) NOT NULL,
user_id                            NUMERIC(100) NOT NULL,
telefone                           CHAR(11) NOT NULL,
CONSTRAINT pfk_user_tel            PRIMARY KEY (cod_tel, user_id)
);

-- Criação da tabela "talentos" junto a sua chave primária "talento_id".


CREATE TABLE talentos (
talento_id                        NUMERIC(100) NOT NULL,
nome_talento                      VARCHAR(100) NOT NULL,
user_id                           NUMERIC(100) NOT NULL,
CONSTRAINT pk_talentos            PRIMARY KEY (talento_id)
);


-- Criação da tabela intermediária "usuario_talento".


CREATE TABLE usuario_talento (
usuario_talento_id               NUMERIC(100) NOT NULL,
user_id                          NUMERIC(100) NOT NULL,
talento_id                       NUMERIC(100) NOT NULL,
CONSTRAINT usuario_talento_pk    PRIMARY KEY (usuario_talento_id)
);


-- Criação da tabela "usuarios" junto a sua chave primária "post_id".

CREATE TABLE postagens (
post_id                            NUMERIC(100) NOT NULL,
user_id                            NUMERIC(100) NOT NULL,
texto                              VARCHAR(255) NOT NULL,
imagem                             BYTEA NULL,
video                              BYTEA NULL,
data_postagem                      DATE NOT NULL,
CONSTRAINT pk_postagens            PRIMARY KEY (post_id)
);

-- Criação da tabela "emails" junto a sua chave primária "cod_email".

CREATE TABLE emails (
cod_email                          NUMERIC(100) NOT NULL,
user_id                            NUMERIC(100) NOT NULL,
email                              VARCHAR(50) NOT NULL,
CONSTRAINT pk_emails               PRIMARY KEY (cod_email)
);

-- Criação da tabela "pedidos" junto a sua chave primária "pedido_id".

CREATE TABLE pedidos (
pedido_id                          NUMERIC(100) NOT NULL,
assunto                            VARCHAR(100) NOT NULL,
descricao                          VARCHAR(200) NOT NULL,
data_pedido                        DATE NOT NULL,
talento_id                         NUMERIC(100) NOT NULL,
user_id                            NUMERIC(100) NOT NULL,
CONSTRAINT pedidodetalento_id      PRIMARY KEY (pedido_id)
);


/*----------------------------------------------------------------------------*/
/* Criação das Constraints de Checagem:                                       */
/*----------------------------------------------------------------------------*/


ALTER TABLE postagens 
ADD CONSTRAINT CHK_postagem
CHECK (texto IS NOT NULL OR imagem IS NOT NULL)
;


/*----------------------------------------------------------------------------*/
/* Criação das Chaves estrangeiras:                                           */
/*----------------------------------------------------------------------------*/


ALTER TABLE pedidos 
ADD CONSTRAINT talentos_pedidos_fk
FOREIGN KEY (talento_id)
REFERENCES talentos (talento_id)
;

ALTER TABLE usuario_talento
ADD CONSTRAINT talentos_usuario_talento_fk
FOREIGN KEY (talento_id)
REFERENCES talentos (talento_id)
;

ALTER TABLE telefones
ADD CONSTRAINT usuarios_telefones_fk
FOREIGN KEY (user_id)
REFERENCES usuarios (user_id)
;

ALTER TABLE postagens
ADD CONSTRAINT usuarios_postagens_fk
FOREIGN KEY (user_id)
REFERENCES usuarios (user_id)
;

ALTER TABLE pedidos
ADD CONSTRAINT usuarios_pedidos_fk
FOREIGN KEY (user_id)
REFERENCES usuarios (user_id)
;

ALTER TABLE usuario_talento 
ADD CONSTRAINT usuarios_usuario_talento_fk
FOREIGN KEY (user_id)
REFERENCES usuarios (user_id)
;

ALTER TABLE emails
ADD CONSTRAINT usuarios_emails_fk
FOREIGN KEY (user_id)
REFERENCES usuarios (user_id)
;
