--squadscrum
begin;
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
 nome varchar(50),
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
 id_colaboradorempresa bigserial not null primary key,
 idempresa bigint,
 idcolaborador bigint
); 

create table colaborador_funcao 
( 
 id_colaboradorfuncao bigserial not null primary key,
 idfuncao bigint,
 idcolaborador bigint
); 

create table colaborador_cargo 
( 
 id_colaboradorcargo bigserial not null primary key,
 idcargo bigint,
 idcolaborador bigint
); 

create table colaborador_equipe
( 
 id_colaboradorequipe bigserial not null primary key,
 idequipe bigint,
 idcolaborador bigint
); 

create table sprint_pesquisa 
( 
 id_sprintpesquisa bigserial not null primary key,
 idpesquisa bigint,
 idsprint bigint
); 

alter table retrospectiva 			add foreign key(idsprint) 				references sprint 					(id_sprint) 				/*on update cascade on delete cascade*/;
alter table retrospectiva 			add foreign key(idcfgretrospectiva) 	references cfgretrospectiva 		(id_cfgretrospectiva) 		/*on update cascade on delete cascade*/;
alter table pesquisa_pergunta 		add foreign key(idpesquisa) 			references pesquisa 				(id_pesquisa) 				/*on update cascade on delete cascade*/;
alter table retrospectiva_item 		add foreign key(idretrospectiva) 		references retrospectiva 			(id_retrospectiva) 			/*on update cascade on delete cascade*/;
alter table retrospectiva_item 		add foreign key(idcfgretrospectivaitem) references cfgretrospectiva_item 	(id_cfgrestrospectivaitem) 	/*on update cascade on delete cascade*/;
alter table cfgretrospectiva_item 	add foreign key(idcfgretrospectiva) 	references cfgretrospectiva 		(id_cfgretrospectiva) 		/*on update cascade on delete cascade*/;
alter table sprint_equipe 			add foreign key(idsprint) 				references sprint 					(id_sprint) 				/*on update cascade on delete cascade*/;
alter table sprint_equipe 			add foreign key(idequipe) 				references equipe 					(id_equipe) 				/*on update cascade on delete cascade*/;
alter table sprint_participante 	add foreign key(idsprintequipe) 		references sprint_equipe 			(id_sprintequipe) 			/*on update cascade on delete cascade*/;
alter table sprint_participante 	add foreign key(idcolaborador) 			references colaborador 				(id_colaborador)  			/*on update cascade on delete cascade*/;
alter table resposta_pesquisa 		add foreign key(idsprintparticipante) 	references sprint_participante 		(id_sprintparticipante) 	/*on update cascade on delete cascade*/;
alter table resposta_pesquisa 		add foreign key(idpesquisapergunta) 	references pesquisa_pergunta 		(id_pesquisapergunta) 		/*on update cascade on delete cascade*/;
alter table cards_retrospectivaitem add foreign key(idretrospectivaitem) 	references retrospectiva_item 		(id_retrospectivaitem) 		/*on update cascade on delete cascade*/;
alter table colaborador_empresa 	add foreign key(idempresa) 				references empresa 					(id_empresa) 				/*on update cascade on delete cascade*/;
alter table colaborador_empresa 	add foreign key(idcolaborador) 			references colaborador 				(id_colaborador) 			/*on update cascade on delete cascade*/;
alter table colaborador_funcao 		add foreign key(idfuncao) 				references funcao 					(id_funcao) 				/*on update cascade on delete cascade*/;
alter table colaborador_funcao 		add foreign key(idcolaborador) 			references colaborador 				(id_colaborador) 			/*on update cascade on delete cascade*/;
alter table colaborador_cargo 		add foreign key(idcargo) 				references cargo 					(id_cargo) 		 			/*on update cascade on delete cascade*/;
alter table colaborador_cargo 		add foreign key(idcolaborador) 			references colaborador 				(id_colaborador) 			/*on update cascade on delete cascade*/;
alter table colaborador_equipe 		add foreign key(idequipe) 				references equipe 					(id_equipe) 	 			/*on update cascade on delete cascade*/;
alter table colaborador_equipe 		add foreign key(idcolaborador) 			references colaborador 				(id_colaborador) 			/*on update cascade on delete cascade*/;
alter table sprint_pesquisa 		add foreign key(idpesquisa) 			references pesquisa 				(id_pesquisa) 	 			/*on update cascade on delete cascade*/;
alter table sprint_pesquisa 		add foreign key(idsprint) 				references sprint 					(id_sprint) 	 			/*on update cascade on delete cascade*/;

-- commmit;

-- begin; /*create index for id tables*/

create index on public.equipe  					using btree (id_equipe 					asc nulls last) tablespace pg_default;
create index on public.empresa  				using btree (id_empresa 				asc nulls last) tablespace pg_default;
create index on public.funcao  					using btree (id_funcao 					asc nulls last) tablespace pg_default;
create index on public.cargo  					using btree (id_cargo 					asc nulls last) tablespace pg_default;
create index on public.colaborador  			using btree (id_colaborador 			asc nulls last) tablespace pg_default;
create index on public.sprint  					using btree (id_sprint 					asc nulls last) tablespace pg_default;
create index on public.pesquisa  				using btree (id_pesquisa 				asc nulls last) tablespace pg_default;
create index on public.retrospectiva  			using btree (id_retrospectiva 			asc nulls last) tablespace pg_default;
create index on public.pesquisa_pergunta  		using btree (id_pesquisapergunta 		asc nulls last) tablespace pg_default;
create index on public.retrospectiva_item  		using btree (id_retrospectivaitem 		asc nulls last) tablespace pg_default;
create index on public.cfgretrospectiva_item  	using btree (id_cfgrestrospectivaitem 	asc nulls last) tablespace pg_default;
create index on public.cfgretrospectiva  		using btree (id_cfgretrospectiva 		asc nulls last) tablespace pg_default;
create index on public.sprint_equipe  			using btree (id_sprintequipe 			asc nulls last) tablespace pg_default;
create index on public.sprint_participante  	using btree (id_sprintparticipante 		asc nulls last) tablespace pg_default;
create index on public.resposta_pesquisa  		using btree (id_respostapesquisa 		asc nulls last) tablespace pg_default;
create index on public.cards_retrospectivaitem  using btree (id_cardsretrospectivaitem 	asc nulls last) tablespace pg_default;
create index on public.colaborador_empresa  	using btree (id_colaboradorempresa 		asc nulls last) tablespace pg_default;
create index on public.colaborador_funcao  		using btree (id_colaboradorfuncao 		asc nulls last) tablespace pg_default;
create index on public.colaborador_cargo  		using btree (id_colaboradorcargo 		asc nulls last) tablespace pg_default;
create index on public.colaborador_equipe 		using btree (id_colaboradorequipe 		asc nulls last) tablespace pg_default;
create index on public.sprint_pesquisa  		using btree (id_sprintpesquisa 			asc nulls last) tablespace pg_default;

-- commmit;

-- begin; /*insert default values - master*/

insert into public.empresa(
	id_empresa, nome)
	values (nextval('public.empresa_id_empresa_seq'), 'Empresa Master');

insert into public.cargo(
	id_cargo, descricao)
	values (nextval('public.cargo_id_cargo_seq'), 'Cargo Master');

insert into public.cargo(
	id_cargo, descricao)
	values (nextval('public.cargo_id_cargo_seq'), 'Analista');

insert into public.cargo(
	id_cargo, descricao)
	values (nextval('public.cargo_id_cargo_seq'), 'Desenvolvedor');

insert into public.cargo(
	id_cargo, descricao)
	values (nextval('public.cargo_id_cargo_seq'), 'Product Owner');

insert into public.funcao(
	id_funcao, descricao)
	values (nextval('public.funcao_id_funcao_seq'), 'Scrum Master');

insert into public.colaborador(
	id_colaborador, usuario, senha, nome, gerenciapesquisa, gerenciausuario)
	values (nextval('public.colaborador_id_colaborador_seq'), 'master', md5('usr!master23'), 'master', false, false);

insert into public.colaborador_empresa(
	idempresa, idcolaborador)
	values (1, 1);

insert into public.colaborador_cargo(
	idcargo, idcolaborador)
	values (1, 1);
