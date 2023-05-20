BEGIN; teste

CREATE TABLE usuario 
( 
 id_usuario bigserial NOT NULL,  
 apelido VARCHAR(50),  
 usuario VARCHAR(50) NOT NULL,  
 senha VARCHAR(50) NOT NULL,  
 gerenciaPesquisa boolean NOT NULL default false,  
 gerenciaUsuario boolean NOT NULL default false,   
 UNIQUE (usuario),
 PRIMARY KEY (id_usuario)
); 

CREATE TABLE empresa 
( 
 id_empresa bigserial NOT NULL,
 nome VARCHAR(50) NOT NULL,
 PRIMARY KEY (id_empresa)
); 

CREATE TABLE cargo 
( 
 descricao VARCHAR(50) NOT NULL,  
 id_cargo bigserial NOT NULL,
 PRIMARY KEY (id_cargo)
); 

CREATE TABLE funcao 
( 
 descricao VARCHAR(50) NOT NULL,  
 id_funcao bigserial NOT NULL,
 PRIMARY KEY (id_funcao)
); 

CREATE TABLE equipe 
( 
 id_equipe bigserial NOT NULL,
 nome VARCHAR(50) NOT NULL,
 PRIMARY KEY (id_equipe) 
); 

CREATE TABLE sprint 
( 
 id_sprint bigserial NOT NULL,
 nome VARCHAR(50) NOT NULL,  
 dataFinal date,  
 dataInicio date ,
 PRIMARY KEY (id_sprint) 
); 

CREATE TABLE retrospectiva 
( 
 alcancado boolean NOT NULL default false,  
 nome VARCHAR(50) NOT NULL,  
 id_retrospectiva bigserial NOT NULL,
 PRIMARY KEY (id_retrospectiva)
); 

CREATE TABLE pesquisa 
( 
 id_pesquisa bigserial NOT NULL,
 titulo VARCHAR(50) NOT NULL,
 PRIMARY KEY (id_pesquisa) 
); 

CREATE TABLE pergunta 
( 
 id_pergunta bigserial NOT NULL,
 pergunta VARCHAR(50) NOT NULL,  
 tiporesposta CHAR NOT NULL DEFAULT 'd',
 valorInicial VARCHAR(50),  
 valorFinal VARCHAR(50),  
 tamanhoTotal INT,  
 id_pesquisa bigint,
 CHECK (tiporesposta LIKE '%d, s, b%'),
 PRIMARY KEY (id_pergunta)
); 

CREATE TABLE melhorar 
( 
 id_melhorar bigserial NOT NULL,
 descricao VARCHAR(50) NOT NULL,  
 id_retrospectiva bigint,
 PRIMARY KEY (id_melhorar) 
); 

CREATE TABLE queFoiRuim 
( 
 id_queFoiRuim bigserial NOT NULL,
 descricao VARCHAR(50) NOT NULL,
 id_retrospectiva bigint ,
 PRIMARY KEY (id_queFoiRuim) 
); 

CREATE TABLE queFoiBom 
( 
 id_queFoiBom bigserial NOT NULL,
 descricao VARCHAR(50) NOT NULL,
 id_retrospectiva bigint,
 PRIMARY KEY (id_queFoiBom)  
); 

CREATE TABLE fatores 
( 
 id_fatores bigserial NOT NULL,
 descricao VARCHAR(50) NOT NULL,
 id_retrospectiva bigint,
 PRIMARY KEY (id_fatores)
); 

CREATE TABLE incremento 
( 
 id_incremento bigserial NOT NULL,
 descricao VARCHAR(50) NOT NULL,
 id_retrospectiva bigint,
 PRIMARY KEY (id_incremento)  
); 

CREATE TABLE meta 
( 
 id_meta bigserial NOT NULL,
 descricao VARCHAR(50) NOT NULL,
 id_retrospectiva bigint ,
 PRIMARY KEY (id_meta) 
); 

CREATE TABLE usuario_equipe 
( 
 id_equipe bigint,  
 id_usuario bigint,
 primary key (id_equipe, id_usuario)
); 

CREATE TABLE usuario_empresa 
( 
 id_empresa bigint,  
 id_usuario bigint,
 primary key (id_empresa, id_usuario) 
); 

CREATE TABLE usuario_cargo 
( 
 id_cargo bigint,  
 id_usuario bigint,
 primary key (id_cargo, id_usuario)
); 

CREATE TABLE usuario_funcao 
( 
 id_funcao bigint,  
 id_usuario bigint,
 primary key (id_funcao, id_usuario) 
); 

CREATE TABLE repostaUsuario 
( 
 respostaDouble NUMERIC(18,2),  
 respostaString VARCHAR(50),  
 respostaBoolean BOOLEAN,  
 id_usuario bigint,  
 id_sprint bigint,  
 id_pergunta bigint,  
 id_pesquisa bigint,
 id_respostaUsuario bigserial NOT NULL,
 primary key (id_respostaUsuario)
); 

CREATE TABLE retrospectiva_sprint 
( 
 id_retrospectiva bigint,  
 id_sprint bigint,
 primary key (id_retrospectiva, id_sprint)  
); 

ALTER TABLE melhorar 				ADD FOREIGN KEY(id_retrospectiva) 	REFERENCES retrospectiva 	(id_retrospectiva);
ALTER TABLE queFoiRuim 				ADD FOREIGN KEY(id_retrospectiva) 	REFERENCES retrospectiva 	(id_retrospectiva);
ALTER TABLE queFoiBom 				ADD FOREIGN KEY(id_retrospectiva) 	REFERENCES retrospectiva 	(id_retrospectiva);
ALTER TABLE fatores 				ADD FOREIGN KEY(id_retrospectiva) 	REFERENCES retrospectiva 	(id_retrospectiva);
ALTER TABLE incremento 				ADD FOREIGN KEY(id_retrospectiva) 	REFERENCES retrospectiva 	(id_retrospectiva);
ALTER TABLE meta 					ADD FOREIGN KEY(id_retrospectiva) 	REFERENCES retrospectiva 	(id_retrospectiva);
ALTER TABLE usuario_equipe 			ADD FOREIGN KEY(id_equipe)  		REFERENCES equipe 			(id_equipe);
ALTER TABLE usuario_equipe 			ADD FOREIGN KEY(id_usuario) 		REFERENCES usuario  		(id_usuario);
ALTER TABLE usuario_empresa			ADD FOREIGN KEY(id_empresa) 		REFERENCES empresa  		(id_empresa);
ALTER TABLE usuario_empresa			ADD FOREIGN KEY(id_usuario) 		REFERENCES usuario  		(id_usuario);
ALTER TABLE usuario_cargo  			ADD FOREIGN KEY(id_cargo)   		REFERENCES cargo 			(id_cargo);
ALTER TABLE usuario_cargo  			ADD FOREIGN KEY(id_usuario) 		REFERENCES usuario  		(id_usuario);
ALTER TABLE usuario_funcao 			ADD FOREIGN KEY(id_funcao)  		REFERENCES funcao 			(id_funcao);
ALTER TABLE usuario_funcao 			ADD FOREIGN KEY(id_usuario) 		REFERENCES usuario  		(id_usuario);
ALTER TABLE repostaUsuario 			ADD FOREIGN KEY(id_usuario) 		REFERENCES usuario  		(id_usuario);
ALTER TABLE repostaUsuario 			ADD FOREIGN KEY(id_sprint)  		REFERENCES sprint 			(id_sprint);
ALTER TABLE repostaUsuario 			ADD FOREIGN KEY(id_pergunta)		REFERENCES pergunta 		(id_pergunta);
ALTER TABLE repostaUsuario 			ADD FOREIGN KEY(id_pesquisa)		REFERENCES pesquisa 		(id_pesquisa);
ALTER TABLE retrospectiva_sprint 	ADD FOREIGN KEY(id_retrospectiva) 	REFERENCES retrospectiva 	(id_retrospectiva);
ALTER TABLE retrospectiva_sprint 	ADD FOREIGN KEY(id_sprint)        	REFERENCES sprint 			(id_sprint);
ALTER TABLE pergunta 				ADD FOREIGN KEY(id_pesquisa)        REFERENCES pesquisa			(id_pesquisa);