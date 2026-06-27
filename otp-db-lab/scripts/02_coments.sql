COMMENT ON TABLE occurrence IS
'Tabela central do sistema. Registra uma ocorrência urbana aberta por cidadão, integração externa ou operador interno.';

COMMENT ON COLUMN occurrence.id IS
'Identificador técnico interno da ocorrência. Usado como chave primária e referência por outras tabelas.';

COMMENT ON COLUMN occurrence.protocol IS
'Protocolo público da ocorrência. Usado para busca, atendimento e comunicação com o solicitante.';

COMMENT ON COLUMN occurrence.external_code IS
'Código externo opcional recebido de outro sistema ou legado. Pode ser nulo quando a ocorrência nasce no próprio sistema.';

COMMENT ON COLUMN occurrence.title IS
'Título resumido informado para a ocorrência. Normalmente usado em telas e listas.';

COMMENT ON COLUMN occurrence.description IS
'Descrição detalhada do problema informado pelo solicitante ou pelo sistema integrador.';

COMMENT ON COLUMN occurrence.category_id IS
'Categoria da ocorrência. Aponta para category.id e define o tipo do problema registrado.';

COMMENT ON COLUMN occurrence.address_id IS
'Endereço associado à ocorrência. Aponta para address.id.';

COMMENT ON COLUMN occurrence.requester_user_id IS
'Usuário solicitante da ocorrência. Pode ser nulo em ocorrências anônimas ou recebidas por integração sem identificação do cidadão.';

COMMENT ON COLUMN occurrence.priority_id IS
'Prioridade atribuída à ocorrência. Aponta para priority.id e influencia SLA e ordenação operacional.';

COMMENT ON COLUMN occurrence.origin IS
'Origem da ocorrência. Exemplos: APP, WEB, CALL_CENTER, INTEGRATION, INTERNAL.';

COMMENT ON COLUMN occurrence.created_at IS
'Data e hora de criação da ocorrência no sistema.';

COMMENT ON COLUMN occurrence.updated_at IS
'Data e hora da última atualização direta no registro principal da ocorrência. Nem toda mudança de status altera esta coluna.';

COMMENT ON COLUMN occurrence.canceled_at IS
'Data e hora de cancelamento da ocorrência. Nulo quando a ocorrência não foi cancelada.';