SELECT current_database(), current_schema();

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

SELECT COUNT(*) AS total_bairros FROM bairros;
SELECT COUNT(*) AS total_categorias FROM categorias;
SELECT COUNT(*) AS total_ocorrencias FROM ocorrencias;
SELECT COUNT(*) AS total_fotos FROM fotos_ocorrencia;
SELECT COUNT(*) AS total_historicos FROM historico_status_ocorrencia;
SELECT COUNT(*) AS total_atribuicoes FROM atribuicoes_ocorrencia;

select * from ocorrencias;

select 
	id,
	protocolo,
	titulo,
	criada_em
from ocorrencias;

--[exercicio] Listar as 5 ocorrências mais recentes.
select
	id,
	protocolo,
	titulo,
	criada_em
from ocorrencias
order by criada_em desc
limit 5;

--Descobrir colunas via SQL
select 
	column_name,
	data_type,
	is_nullable
from information_schema."columns" 
where table_schema = 'public'
	and table_name = 'ocorrencias'
order by ordinal_position;

--Descobrir tabelas do schema
select
	table_name
from information_schema."tables"
where table_schema = 'public'
order by table_name;

--Descobrir chaves estrangeiras
select 
	tc.table_name,
	kcu.column_name,
	ccu.table_name as foreign_table_name,
	ccu.column_name as foreign_column_name
from information_schema.table_constraints tc 
join information_schema.key_column_usage kcu 
	on tc.constraint_name = kcu.constraint_name 
	and tc.table_schema = kcu.table_schema
join information_schema.constraint_column_usage ccu 
	on ccu.constraint_name = tc.constraint_name 
	and ccu.table_schema = tc.table_schema 
where tc.constraint_type = 'FOREIGN KEY'
and tc.table_schema = 'public'
order by tc.table_name;


--[exercicio] Buscar a ocorrência pelo protocolo OTP-2026-0001

select
	id,
	protocolo,
	titulo,
	descricao,
	criada_em
from ocorrencias
where protocolo = 'OTP-2026-0001';


--[exercicio] trazer bairro e categoria para o protocolo OTP-2026-0001
select
	o.id,
	o.protocolo,
	o.titulo,
	b.nome as bairro,
	c.nome as categoria,
	o.criada_em
from ocorrencias o 
join bairros b on b.id = o.bairro_id 
join categorias c on c.id = o.categoria_id 
where o.protocolo = 'OTP-2026-0001';














