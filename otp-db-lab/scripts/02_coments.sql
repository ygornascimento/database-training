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

COMMENT ON TABLE city IS
'Cidades atendidas pelo sistema. Usada como base para bairros/distritos e endereços.';

COMMENT ON TABLE district IS
'Bairros ou distritos vinculados a uma cidade. Ajuda na localização e agrupamento territorial das ocorrências.';

COMMENT ON TABLE address IS
'Endereços físicos associados às ocorrências. Uma ocorrência aponta para um endereço.';

COMMENT ON TABLE app_user IS
'Usuários do sistema, podendo representar cidadãos, operadores internos, líderes de equipe ou técnicos de campo.';

COMMENT ON TABLE department IS
'Departamentos responsáveis pelo atendimento das ocorrências, como Obras, Iluminação, Limpeza Urbana e Defesa Civil.';

COMMENT ON TABLE category IS
'Categorias de ocorrência. Cada categoria pertence a um departamento responsável.';

COMMENT ON TABLE priority IS
'Prioridades operacionais das ocorrências. Usada para ordenação, criticidade e cálculo de SLA.';

COMMENT ON TABLE sla_policy IS
'Políticas de SLA por categoria e prioridade. Define prazo máximo esperado para atendimento.';

COMMENT ON TABLE occurrence IS
'Tabela central do sistema. Registra uma ocorrência urbana aberta por cidadão, integração externa ou operador interno.';

COMMENT ON TABLE occurrence_status IS
'Lista de status possíveis para uma ocorrência. Alguns status representam encerramento do fluxo.';

COMMENT ON TABLE occurrence_status_history IS
'Histórico de mudanças de status de uma ocorrência. Permite descobrir o status atual e a linha do tempo do atendimento.';

COMMENT ON TABLE occurrence_assignment IS
'Registra atribuições de ocorrências para equipes de campo. Uma ocorrência pode ter nenhuma, uma ou várias atribuições ao longo do tempo.';

COMMENT ON TABLE field_team IS
'Equipes de campo responsáveis pelo atendimento operacional das ocorrências.';

COMMENT ON TABLE team_member IS
'Relacionamento entre usuários e equipes de campo. Indica membros e líderes de equipe.';

COMMENT ON TABLE service_order IS
'Ordem de serviço operacional gerada a partir de uma ocorrência. Nem toda ocorrência necessariamente possui ordem de serviço.';

COMMENT ON TABLE service_order_event IS
'Eventos da ordem de serviço, como abertura, deslocamento, chegada, execução e encerramento.';

COMMENT ON TABLE occurrence_attachment IS
'Arquivos anexados à ocorrência, como fotos, documentos e evidências.';

COMMENT ON TABLE occurrence_comment IS
'Comentários vinculados à ocorrência. Podem ser públicos ou internos.';

COMMENT ON TABLE integration_source IS
'Sistemas externos que enviam ou recebem dados de ocorrência.';

COMMENT ON TABLE external_protocol_map IS
'Mapeamento entre protocolo interno da ocorrência e protocolo externo de outro sistema.';

COMMENT ON TABLE integration_message IS
'Mensagens recebidas de sistemas externos. Pode ou não estar vinculada a uma ocorrência já criada.';

COMMENT ON TABLE integration_error IS
'Erros ocorridos durante o processamento de mensagens de integração.';

COMMENT ON TABLE notification IS
'Notificações enviadas ou pendentes para usuários ou canais externos.';

COMMENT ON TABLE audit_log IS
'Registro de auditoria de ações realizadas em entidades do sistema.';

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

COMMENT ON COLUMN occurrence_status_history.occurrence_id IS
'Ocorrência cujo status foi alterado. Aponta para occurrence.id.';

COMMENT ON COLUMN occurrence_status_history.status_id IS
'Status aplicado à ocorrência. Aponta para occurrence_status.id.';

COMMENT ON COLUMN occurrence_status_history.changed_by_user_id IS
'Usuário que realizou a mudança de status. Pode ser nulo quando a alteração foi feita por integração ou processo automático.';

COMMENT ON COLUMN occurrence_status_history.changed_at IS
'Data e hora em que o status foi alterado. Usada para descobrir a linha do tempo e o status atual.';

COMMENT ON COLUMN occurrence_assignment.occurrence_id IS
'Ocorrência atribuída para uma equipe. Aponta para occurrence.id.';

COMMENT ON COLUMN occurrence_assignment.team_id IS
'Equipe responsável pela atribuição. Aponta para field_team.id.';

COMMENT ON COLUMN service_order.occurrence_id IS
'Ocorrência que originou a ordem de serviço. Aponta para occurrence.id.';

COMMENT ON COLUMN integration_message.occurrence_id IS
'Ocorrência associada à mensagem de integração, quando o vínculo já foi identificado.';

COMMENT ON COLUMN integration_message.external_protocol IS
'Protocolo externo recebido na mensagem de integração. Pode ser usado para rastrear mensagens antes de localizar a ocorrência interna.';

COMMENT ON COLUMN integration_message.processed IS
'Indica se a mensagem de integração foi processada com sucesso.';

COMMENT ON COLUMN integration_error.integration_message_id IS
'Mensagem de integração que gerou erro durante o processamento.';

