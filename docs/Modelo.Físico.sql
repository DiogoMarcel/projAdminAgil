begin;
-----------

DROP TABLE cargo CASCADE;
DROP TABLE empresa CASCADE;
DROP TABLE equipe CASCADE;
DROP TABLE fatores CASCADE;
DROP TABLE funcao CASCADE;
DROP TABLE incremento CASCADE;
DROP TABLE melhorar CASCADE;
DROP TABLE meta CASCADE;
DROP TABLE pergunta CASCADE;
DROP TABLE pesquisa CASCADE;
DROP TABLE quefoibom CASCADE;
DROP TABLE quefoiruim CASCADE;
DROP TABLE respostausuario CASCADE;
DROP TABLE retrospectiva CASCADE;
DROP TABLE retrospectiva_sprint CASCADE;
DROP TABLE sprint CASCADE;
DROP TABLE usuario CASCADE;
DROP TABLE usuario_cargo CASCADE;
DROP TABLE usuario_empresa CASCADE;
DROP TABLE usuario_equipe CASCADE;
DROP TABLE usuario_funcao CASCADE;

-----------

create table equipe 
( 
 id_equipe bigserial primary key,
 nome varchar(50)
); 

create table empresa 
( 
 id_empresa bigserial not null primary key,
 nome varchar(50)
); 

create table funcao 
( 
 id_funcao bigserial not null primary key,
 descricao varchar(50)
); 

create table cargo 
( 
 id_cargo bigserial not null primary key,
 descricao varchar(50)
); 

create table colaborador 
( 
 id_colaborador bigserial not null primary key,
 usuario varchar(50),
 senha varchar(50),
 apelido varchar(50),
 gerenciapesquisa boolean,
 gerenciausuario boolean,
 unique (usuario)
);

create table sprint 
( 
 id_sprint bigserial not null primary key,
 nome varchar(50),
 datafinal date not null,
 datainicio date not null 
); 

create table pesquisa 
( 
 id_pesquisa bigserial not null primary key,
 titulo varchar(50)
); 

create table retrospectiva 
( 
 id_retrospectiva bigserial not null primary key,
 metaalcancada boolean not null default false,
 idsprint bigint,
 idcfgretrospectiva bigint
); 

create table pesquisa_pergunta 
( 
 id_pesquisapergunta bigserial not null primary key,
 pergunta varchar(300),
 valorfinal numeric(5,2),
 valorinicial numeric(5,2),
 tiporesposta char not null default 'd',
 tamanhototal int,
 idpesquisa bigint,
 check (tiporesposta like '%d, s, b%')
); 

create table retrospectiva_item 
( 
 id_retrospectivaitem bigserial not null primary key,
 idretrospectiva bigint,
 idcfgretrospectivaitem bigint
); 

create table cfgretrospectiva_item 
( 
 id_cfgrestrospectivaitem bigserial not null primary key,
 descricao varchar(50),
 idcfgretrospectiva bigint
); 

create table cfgretrospectiva 
( 
 id_cfgretrospectiva bigserial not null primary key,
 nome varchar(50)
); 

create table sprint_equipe 
( 
 id_sprintequipe bigserial not null primary key,
 idsprint bigint,
 idequipe bigint
); 

create table sprint_participante 
( 
 id_sprintparticipante bigserial not null primary key,
 idsprintequipe bigint,
 idcolaborador bigint
);

create table resposta_pesquisa 
( 
 id_respostapesquisa bigserial not null primary key,
 respostastring varchar(300),
 respostadouble numeric(5,2),
 respostaboolean boolean,
 idsprintparticipante bigint,
 idpesquisapergunta bigint
); 

create table cards_retrospectivaitem 
( 
 id_cardsretrospectivaitem bigserial not null primary key,
 descricao varchar(50),
 idretrospectivaitem bigint
); 

create table colaborador_empresa 
( 
 id_empresa bigint,
 id_colaborador bigint,
 primary key (id_empresa, id_colaborador)
); 

create table colaborador_funcao 
( 
 id_funcao bigint,
 id_colaborador bigint,
 primary key (id_funcao, id_colaborador)
); 

create table colaborador_cargo 
( 
 id_cargo bigint,
 id_colaborador bigint,
 primary key (id_cargo, id_colaborador)
); 

create table equipe_colaborador 
( 
 id_equipe bigint,
 id_colaborador bigint,
 primary key (id_equipe, id_colaborador)
); 

create table sprint_pesquisa 
( 
 id_sprintpesquisa bigserial not null primary key,
 idpesquisa bigint,
 idsprint bigint
); 

alter table retrospectiva 			add foreign key(idsprint) 				references sprint (id_sprint);
alter table retrospectiva 			add foreign key(idcfgretrospectiva) 	references cfgretrospectiva (id_cfgretrospectiva);
alter table pesquisa_pergunta 		add foreign key(idpesquisa) 			references pesquisa (id_pesquisa);
alter table retrospectiva_item 		add foreign key(idretrospectiva) 		references retrospectiva (id_retrospectiva);
alter table retrospectiva_item 		add foreign key(idcfgretrospectivaitem) references cfgretrospectiva_item (id_cfgrestrospectivaitem);
alter table cfgretrospectiva_item 	add foreign key(idcfgretrospectiva) 	references cfgretrospectiva (id_cfgretrospectiva);
alter table sprint_equipe 			add foreign key(idsprint) 				references sprint (id_sprint);
alter table sprint_equipe 			add foreign key(idequipe) 				references equipe (id_equipe);
alter table sprint_participante 	add foreign key(idsprintequipe) 		references sprint_equipe (id_sprintequipe);
alter table sprint_participante 	add foreign key(idcolaborador) 			references colaborador (id_colaborador);
alter table resposta_pesquisa 		add foreign key(idsprintparticipante) 	references sprint_participante (id_sprintparticipante);
alter table resposta_pesquisa 		add foreign key(idpesquisapergunta) 	references pesquisa_pergunta (id_pesquisapergunta);
alter table cards_retrospectivaitem add foreign key(idretrospectivaitem) 	references retrospectiva_item (id_retrospectivaitem);
alter table colaborador_empresa 	add foreign key(id_empresa) 			references empresa (id_empresa);
alter table colaborador_empresa 	add foreign key(id_colaborador) 		references colaborador (id_colaborador);
alter table colaborador_funcao 		add foreign key(id_funcao) 				references funcao (id_funcao);
alter table colaborador_funcao 		add foreign key(id_colaborador) 		references colaborador (id_colaborador);
alter table colaborador_cargo 		add foreign key(id_cargo) 				references cargo (id_cargo);
alter table colaborador_cargo 		add foreign key(id_colaborador) 		references colaborador (id_colaborador);
alter table equipe_colaborador 		add foreign key(id_equipe) 				references equipe (id_equipe);
alter table equipe_colaborador 		add foreign key(id_colaborador) 		references colaborador (id_colaborador);
alter table sprint_pesquisa 		add foreign key(idpesquisa) 			references pesquisa (id_pesquisa);
alter table sprint_pesquisa 		add foreign key(idsprint) 				references sprint (id_sprint);
