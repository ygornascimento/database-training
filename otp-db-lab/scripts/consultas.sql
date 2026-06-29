--- Confirmar conexão e informações sobre a conexão.
select
    current_database(),
    current_schema(),
    current_user;

select
    current_database() as database_name,
    current_schema() as schema_name,
    current_user as connected_user;

--- Confirmar conexão e informações mais commpletas sobre a conexão
SELECT
    current_database() AS database_name,
    current_schema() AS schema_name,
    current_user AS connected_user,
    inet_server_addr() AS server_ip,
    inet_server_port() AS server_port,
    inet_client_addr() AS client_ip,
    inet_client_port() AS client_port;

SELECT
    version() AS postgres_version,
    current_database() AS database_name,
    current_schema() AS schema_name,
    current_user AS connected_user,
    inet_server_addr() AS server_ip,
    inet_server_port() AS server_port;

--- Listar tabelas do schema
select
    table_schema,
    table_name
from information_schema.tables
where table_schema = 'public'
and table_type = 'BASE TABLE'
order by table_name;

--- Listar tabelas do schema com mais informações
select
    c.relname as table_name,
    -- ^ traz o nome da tabela
    obj_description(c.oid, 'pg_class') as table_comment
    -- ^ traz o comentário cadastrado para a tabela existir
from pg_class c
join pg_namespace n on n.oid = c.relnamespace
-- ^ Consulta os catálogos internos do PostgreSQL. pg_class guarda tabelas, índices, views etc.
where n.nspname = 'public'
and c.relkind = 'r'
-- ^ Filtra apenas tabelas comuns do schema public.
order by c.relname;
-- ^ Ordena pelo nome da tabela.

--- Ler colunas e comentários da tabela occurrence
select
    a.attname as column_name,
    -- ^ Traz o nome da coluna.
    format_type(a.atttypid, a.atttypmod) as data_type,
    -- ^ Mostra o tipo da coluna de forma legível, por exemplo bigint, character varying(40), timestamp.
    case
        when a.attnotnull then 'NO'
        else 'YES'
        -- ^ Mostra se a coluna aceita NULL.
    end as is_nullable,
    col_description(a.attrelid, a.attnum) as column_coment
    -- ^ Busca o comentário da coluna.
from pg_attribute a
where a.attrelid = 'public.occurrence'::regclass
  -- ^ Diz que queremos investigar a tabela public.occurrence.
    and a.attnum > 0
    and not a.attisdropped
    -- ^ Remove colunas internas do PostgreSQL e colunas apagadas.
order by a.attnum;

--- Descobrir PK e FKs da tabela occurrence - Pergunta investigativa: “Qual coluna identifica uma ocorrência e para quais tabelas ela aponta?”
select
    tc.table_name,
    kcu.column_name
from information_schema.table_constraints tc
join information_schema.key_column_usage kcu
    on tc.constraint_name = kcu.constraint_name
    and tc.table_schema = kcu.table_schema
where tc.constraint_type = 'PRIMARY KEY'
    and tc.table_schema = 'public'
    and tc.table_name = 'occurrence';

--- Descobrir para quais tabelas occurrence aponta - Pergunta investigativa: “A tabela occurrence depende de quais outras tabelas?”
SELECT
    tc.table_name,
    kcu.column_name,
    ccu.table_name AS referenced_table,
    ccu.column_name AS referenced_column
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
   AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage ccu
    ON ccu.constraint_name = tc.constraint_name
   AND ccu.table_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_schema = 'public'
  AND tc.table_name = 'occurrence'
ORDER BY kcu.column_name;


/*
Checkpoint:
Banco: otp_legacy_lab
Tabela central: occurrence
PK da occurrence: id
Próximo passo: descobrir as FKs da occurrence
Lição importante: comentário explica significado; nulidade muda o tipo de JOIN.
 */

/*
Regra prática para você no trabalho
Quando encontrar uma FK, pergunte:
1. Quem tem a FK?
2. Para quem ela aponta?
3. A coluna aceita NULL?
4. Essa tabela é referência, histórico, evento ou entidade principal?
5. Esse relacionamento é obrigatório ou opcional?
6. Para consultar, uso JOIN ou LEFT JOIN?
 */

--- Descobrir quem aponta para occurrence - Pergunta investigativa: “Quais tabelas registram informações relacionadas a uma ocorrência?” Ou, tecnicamente: “Quais tabelas possuem uma FK apontando para occurrence.id?”

SELECT
    tc.table_name AS source_table,
    kcu.column_name AS source_column,
    ccu.table_name AS referenced_table,
    ccu.column_name AS referenced_column
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
   AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage ccu
    ON ccu.constraint_name = tc.constraint_name
   AND ccu.table_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_schema = 'public'
  AND ccu.table_name = 'occurrence'
  AND ccu.column_name = 'id'
ORDER BY tc.table_name, kcu.column_name;

-- Primeira query real de investigação - Pergunta investigativa: “Quais são as ocorrências cadastradas e quais informações básicas consigo ver diretamente na tabela central?”
SELECT
    id,
    protocol,
    external_code,
    title,
    origin,
    created_at,
    canceled_at
FROM occurrence
ORDER BY created_at DESC
LIMIT 20;