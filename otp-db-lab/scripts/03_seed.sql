TRUNCATE TABLE
    audit_log,
    notification,
    integration_error,
    integration_message,
    external_protocol_map,
    service_order_event,
    service_order,
    occurrence_assignment,
    team_member,
    field_team,
    occurrence_status_history,
    occurrence_attachment,
    occurrence_comment,
    occurrence,
    sla_policy,
    priority,
    occurrence_status,
    category,
    department,
    app_user_role,
    app_role,
    app_user,
    address,
    district,
    city,
    integration_source
RESTART IDENTITY CASCADE;

INSERT INTO city (name, state_code, active) VALUES
('Rio das Ostras', 'RJ', TRUE),
('Macaé', 'RJ', TRUE);

INSERT INTO district (city_id, name, legacy_code) VALUES
(1, 'Centro', 'RO-CEN'),
(1, 'Costa Azul', 'RO-CAZ'),
(1, 'Jardim Mariléa', 'RO-JMA'),
(1, 'Âncora', 'RO-ANC'),
(1, 'Nova Cidade', 'RO-NCI'),
(1, 'Village', 'RO-VIL'),
(1, 'Operário', 'RO-OPE'),
(1, 'Cidade Praiana', 'RO-CPR'),
(2, 'Imbetiba', 'MAC-IMB'),
(2, 'Cavaleiros', 'MAC-CAV');

INSERT INTO address (district_id, street, number, complement, postal_code, latitude, longitude) VALUES
(1, 'Rua Bangu', '100', NULL, '28890-000', -22.5261000, -41.9452000),
(1, 'Avenida Amazonas', '250', 'Próximo à praça', '28890-001', -22.5265000, -41.9460000),
(2, 'Avenida Costa Azul', '1500', NULL, '28895-000', -22.5200000, -41.9300000),
(3, 'Rua das Acácias', '45', NULL, '28896-000', -22.5100000, -41.9200000),
(4, 'Rua Projetada A', 'S/N', 'Lote 12', '28897-000', -22.5000000, -41.9100000),
(5, 'Rua Nova Esperança', '88', NULL, '28898-000', -22.4900000, -41.9000000),
(6, 'Rua do Canal', '300', NULL, '28899-000', -22.4800000, -41.8900000),
(7, 'Rua dos Trabalhadores', '70', NULL, '28891-000', -22.4700000, -41.8800000),
(8, 'Rua da Praia', '500', 'Em frente à escola', '28892-000', -22.4600000, -41.8700000),
(9, 'Rua da Glória', '10', NULL, '27913-000', -22.3760000, -41.7750000),
(10, 'Avenida Atlântica', '2000', NULL, '27920-000', -22.4050000, -41.8150000);

INSERT INTO app_role (name) VALUES
('CITIZEN'),
('OPERATOR'),
('FIELD_AGENT'),
('TEAM_LEADER'),
('ADMIN');

INSERT INTO app_user (full_name, email, document_number, phone, active, created_at) VALUES
('Ana Souza', 'ana.souza@email.com', '11111111111', '22999990001', TRUE, CURRENT_TIMESTAMP - INTERVAL '200 days'),
('Bruno Lima', 'bruno.lima@email.com', '22222222222', '22999990002', TRUE, CURRENT_TIMESTAMP - INTERVAL '190 days'),
('Carla Mendes', 'carla.mendes@email.com', '33333333333', '22999990003', TRUE, CURRENT_TIMESTAMP - INTERVAL '180 days'),
('Diego Rocha', 'diego.rocha@email.com', '44444444444', '22999990004', TRUE, CURRENT_TIMESTAMP - INTERVAL '170 days'),
('Eduarda Nunes', 'eduarda.nunes@email.com', '55555555555', '22999990005', TRUE, CURRENT_TIMESTAMP - INTERVAL '160 days'),
('Fernando Castro', 'fernando.castro@email.com', '66666666666', '22999990006', TRUE, CURRENT_TIMESTAMP - INTERVAL '150 days'),
('Gabriela Torres', 'gabriela.torres@email.com', '77777777777', '22999990007', TRUE, CURRENT_TIMESTAMP - INTERVAL '140 days'),
('Henrique Alves', 'henrique.alves@email.com', '88888888888', '22999990008', TRUE, CURRENT_TIMESTAMP - INTERVAL '130 days'),
('Operador Interno', 'operador@otp.local', NULL, NULL, TRUE, CURRENT_TIMESTAMP - INTERVAL '300 days'),
('Sistema Integrador', 'integrador@otp.local', NULL, NULL, TRUE, CURRENT_TIMESTAMP - INTERVAL '300 days');

INSERT INTO app_user_role (user_id, role_id) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1),
(6, 3), (7, 3), (8, 4), (9, 2), (10, 5);

INSERT INTO department (name, acronym, active) VALUES
('Secretaria de Obras', 'OBRAS', TRUE),
('Iluminação Pública', 'ILUM', TRUE),
('Limpeza Urbana', 'LIMP', TRUE),
('Defesa Civil', 'DEF', TRUE),
('Trânsito', 'TRANS', TRUE),
('Saneamento', 'SAN', TRUE);

INSERT INTO category (department_id, name, active) VALUES
(1, 'Buraco na via', TRUE),
(1, 'Calçada danificada', TRUE),
(2, 'Poste apagado', TRUE),
(2, 'Lâmpada piscando', TRUE),
(3, 'Lixo acumulado', TRUE),
(3, 'Entulho irregular', TRUE),
(4, 'Alagamento', TRUE),
(4, 'Árvore caída', TRUE),
(5, 'Sinalização danificada', TRUE),
(6, 'Esgoto a céu aberto', TRUE);

INSERT INTO occurrence_status (name, is_final) VALUES
('Aberta', FALSE),
('Em análise', FALSE),
('Atribuída', FALSE),
('Em atendimento', FALSE),
('Aguardando material', FALSE),
('Resolvida', TRUE),
('Cancelada', TRUE),
('Reaberta', FALSE);

INSERT INTO priority (name, weight) VALUES
('Baixa', 1),
('Média', 2),
('Alta', 3),
('Crítica', 4);

INSERT INTO sla_policy (category_id, priority_id, max_hours, active)
SELECT c.id, p.id,
       CASE
           WHEN p.name = 'Crítica' THEN 12
           WHEN p.name = 'Alta' THEN 24
           WHEN p.name = 'Média' THEN 72
           ELSE 120
       END AS max_hours,
       TRUE
FROM category c
CROSS JOIN priority p;

INSERT INTO field_team (department_id, name, active) VALUES
(1, 'Equipe Pavimentação A', TRUE),
(1, 'Equipe Pavimentação B', TRUE),
(2, 'Equipe Iluminação Norte', TRUE),
(2, 'Equipe Iluminação Sul', TRUE),
(3, 'Equipe Limpeza Urbana', TRUE),
(4, 'Equipe Defesa Civil', TRUE),
(5, 'Equipe Trânsito', TRUE),
(6, 'Equipe Saneamento', TRUE),
(1, 'Equipe Legada Inativa', FALSE);

INSERT INTO team_member (team_id, user_id, leader, active) VALUES
(1, 6, FALSE, TRUE),
(1, 8, TRUE, TRUE),
(3, 7, FALSE, TRUE),
(3, 8, TRUE, TRUE),
(5, 6, TRUE, TRUE),
(6, 7, TRUE, TRUE),
(8, 6, FALSE, TRUE);

INSERT INTO integration_source (name, active) VALUES
('APP_MOBILE', TRUE),
('PORTAL_WEB', TRUE),
('CALL_CENTER', TRUE),
('LEGACY_PROTOCOL_SYSTEM', TRUE),
('THIRD_PARTY_CITY_API', TRUE);

INSERT INTO occurrence (
    protocol,
    external_code,
    title,
    description,
    category_id,
    address_id,
    requester_user_id,
    priority_id,
    origin,
    created_at,
    updated_at,
    canceled_at
)
SELECT
    'OTP-2026-' || LPAD(gs::text, 5, '0') AS protocol,
    CASE
        WHEN gs % 4 = 0 THEN 'LEG-' || LPAD((90000 + gs)::text, 6, '0')
        ELSE NULL
    END AS external_code,
    CASE ((gs - 1) % 10) + 1
        WHEN 1 THEN 'Buraco na via principal'
        WHEN 2 THEN 'Calçada danificada'
        WHEN 3 THEN 'Poste apagado'
        WHEN 4 THEN 'Lâmpada piscando'
        WHEN 5 THEN 'Lixo acumulado'
        WHEN 6 THEN 'Entulho irregular'
        WHEN 7 THEN 'Alagamento recorrente'
        WHEN 8 THEN 'Árvore caída'
        WHEN 9 THEN 'Sinalização danificada'
        WHEN 10 THEN 'Esgoto a céu aberto'
    END AS title,
    'Descrição detalhada da ocorrência número ' || gs || '. Registro criado para simular investigação em base legada.' AS description,
    ((gs - 1) % 10) + 1 AS category_id,
    ((gs - 1) % 11) + 1 AS address_id,
    CASE
        WHEN gs % 7 = 0 THEN NULL
        WHEN gs % 4 = 0 THEN NULL
        ELSE ((gs - 1) % 5) + 1
    END AS requester_user_id,
    CASE
        WHEN gs % 17 = 0 THEN 4
        WHEN gs % 5 = 0 THEN 3
        WHEN gs % 2 = 0 THEN 2
        ELSE 1
    END AS priority_id,
    CASE
        WHEN gs % 4 = 0 THEN 'INTEGRATION'
        WHEN gs % 5 = 0 THEN 'CALL_CENTER'
        WHEN gs % 3 = 0 THEN 'WEB'
        ELSE 'APP'
    END AS origin,
    CURRENT_TIMESTAMP - (gs || ' days')::INTERVAL AS created_at,
    CASE
        WHEN gs % 3 = 0 THEN CURRENT_TIMESTAMP - ((gs - 1) || ' days')::INTERVAL
        ELSE NULL
    END AS updated_at,
    CASE
        WHEN gs % 19 = 0 THEN CURRENT_TIMESTAMP - ((gs - 2) || ' days')::INTERVAL
        ELSE NULL
    END AS canceled_at
FROM generate_series(1, 120) gs;

INSERT INTO occurrence_status_history (
    occurrence_id,
    status_id,
    changed_by_user_id,
    note,
    changed_at
)
SELECT
    o.id,
    1,
    o.requester_user_id,
    'Ocorrência registrada.',
    o.created_at
FROM occurrence o;

INSERT INTO occurrence_status_history (
    occurrence_id,
    status_id,
    changed_by_user_id,
    note,
    changed_at
)
SELECT
    o.id,
    2,
    9,
    'Ocorrência encaminhada para análise.',
    o.created_at + INTERVAL '6 hours'
FROM occurrence o
WHERE o.id % 2 = 0 OR o.id % 3 = 0;

INSERT INTO occurrence_status_history (
    occurrence_id,
    status_id,
    changed_by_user_id,
    note,
    changed_at
)
SELECT
    o.id,
    3,
    9,
    'Ocorrência atribuída a uma equipe.',
    o.created_at + INTERVAL '12 hours'
FROM occurrence o
WHERE o.id % 3 = 0 OR o.id % 5 = 0;

INSERT INTO occurrence_status_history (
    occurrence_id,
    status_id,
    changed_by_user_id,
    note,
    changed_at
)
SELECT
    o.id,
    4,
    8,
    'Equipe iniciou atendimento em campo.',
    o.created_at + INTERVAL '18 hours'
FROM occurrence o
WHERE o.id % 5 = 0 OR o.id % 6 = 0;

INSERT INTO occurrence_status_history (
    occurrence_id,
    status_id,
    changed_by_user_id,
    note,
    changed_at
)
SELECT
    o.id,
    6,
    8,
    'Ocorrência resolvida pela equipe responsável.',
    o.created_at + INTERVAL '2 days'
FROM occurrence o
WHERE o.id % 6 = 0;

INSERT INTO occurrence_status_history (
    occurrence_id,
    status_id,
    changed_by_user_id,
    note,
    changed_at
)
SELECT
    o.id,
    7,
    9,
    'Ocorrência cancelada por duplicidade ou inconsistência.',
    o.canceled_at
FROM occurrence o
WHERE o.canceled_at IS NOT NULL;

INSERT INTO occurrence_attachment (occurrence_id, file_url, file_type, created_at)
SELECT
    o.id,
    'https://storage.fake/occurrences/' || o.protocol || '-photo-1.jpg',
    'PHOTO',
    o.created_at + INTERVAL '10 minutes'
FROM occurrence o
WHERE o.id % 4 <> 0;

INSERT INTO occurrence_attachment (occurrence_id, file_url, file_type, created_at)
SELECT
    o.id,
    'https://storage.fake/occurrences/' || o.protocol || '-photo-2.jpg',
    'PHOTO',
    o.created_at + INTERVAL '20 minutes'
FROM occurrence o
WHERE o.id % 9 = 0;

INSERT INTO occurrence_comment (occurrence_id, user_id, comment_text, internal_only, created_at)
SELECT
    o.id,
    9,
    'Comentário interno de triagem para a ocorrência ' || o.protocol,
    TRUE,
    o.created_at + INTERVAL '2 hours'
FROM occurrence o
WHERE o.id % 3 = 0;

INSERT INTO occurrence_comment (occurrence_id, user_id, comment_text, internal_only, created_at)
SELECT
    o.id,
    o.requester_user_id,
    'Solicitante informou novas evidências.',
    FALSE,
    o.created_at + INTERVAL '1 day'
FROM occurrence o
WHERE o.requester_user_id IS NOT NULL
  AND o.id % 8 = 0;

INSERT INTO occurrence_assignment (
    occurrence_id,
    team_id,
    assigned_by_user_id,
    assigned_at,
    closed_at
)
SELECT
    o.id,
    CASE
        WHEN c.department_id = 1 THEN 1
        WHEN c.department_id = 2 THEN 3
        WHEN c.department_id = 3 THEN 5
        WHEN c.department_id = 4 THEN 6
        WHEN c.department_id = 5 THEN 7
        WHEN c.department_id = 6 THEN 8
        ELSE 1
    END AS team_id,
    9,
    o.created_at + INTERVAL '12 hours',
    CASE
        WHEN o.id % 6 = 0 THEN o.created_at + INTERVAL '2 days'
        ELSE NULL
    END AS closed_at
FROM occurrence o
JOIN category c ON c.id = o.category_id
WHERE o.id % 3 = 0 OR o.id % 5 = 0;

INSERT INTO service_order (
    occurrence_id,
    order_number,
    team_id,
    opened_at,
    closed_at,
    result_note
)
SELECT
    oa.occurrence_id,
    'OS-2026-' || LPAD(oa.id::text, 5, '0'),
    oa.team_id,
    oa.assigned_at + INTERVAL '1 hour',
    oa.closed_at,
    CASE
        WHEN oa.closed_at IS NOT NULL THEN 'Serviço executado e encerrado.'
        ELSE NULL
    END
FROM occurrence_assignment oa
WHERE oa.occurrence_id % 5 = 0 OR oa.occurrence_id % 6 = 0;

INSERT INTO service_order_event (
    service_order_id,
    event_type,
    event_note,
    event_at
)
SELECT
    so.id,
    'OPENED',
    'Ordem de serviço aberta.',
    so.opened_at
FROM service_order so;

INSERT INTO service_order_event (
    service_order_id,
    event_type,
    event_note,
    event_at
)
SELECT
    so.id,
    'FIELD_STARTED',
    'Equipe iniciou deslocamento.',
    so.opened_at + INTERVAL '2 hours'
FROM service_order so
WHERE so.id % 2 = 0;

INSERT INTO service_order_event (
    service_order_id,
    event_type,
    event_note,
    event_at
)
SELECT
    so.id,
    'CLOSED',
    'Ordem de serviço encerrada.',
    so.closed_at
FROM service_order so
WHERE so.closed_at IS NOT NULL;

INSERT INTO external_protocol_map (
    occurrence_id,
    source_id,
    external_protocol,
    created_at
)
SELECT
    o.id,
    4,
    o.external_code,
    o.created_at
FROM occurrence o
WHERE o.external_code IS NOT NULL;

INSERT INTO integration_message (
    source_id,
    occurrence_id,
    external_protocol,
    payload,
    processed,
    processed_at,
    received_at
)
SELECT
    4,
    o.id,
    o.external_code,
    jsonb_build_object(
        'externalCode', o.external_code,
        'protocol', o.protocol,
        'title', o.title,
        'origin', o.origin
    ),
    TRUE,
    o.created_at + INTERVAL '5 minutes',
    o.created_at - INTERVAL '10 minutes'
FROM occurrence o
WHERE o.external_code IS NOT NULL;

INSERT INTO integration_message (
    source_id,
    occurrence_id,
    external_protocol,
    payload,
    processed,
    processed_at,
    received_at
)
SELECT
    5,
    NULL,
    'EXT-ERR-' || LPAD(gs::text, 5, '0'),
    jsonb_build_object(
        'externalCode', 'EXT-ERR-' || LPAD(gs::text, 5, '0'),
        'errorScenario', 'missing required address'
    ),
    FALSE,
    NULL,
    CURRENT_TIMESTAMP - (gs || ' hours')::INTERVAL
FROM generate_series(1, 12) gs;

INSERT INTO integration_error (
    integration_message_id,
    error_code,
    error_message,
    created_at
)
SELECT
    im.id,
    'ADDR_NOT_FOUND',
    'Endereço obrigatório não localizado na mensagem de integração.',
    im.received_at + INTERVAL '2 minutes'
FROM integration_message im
WHERE im.processed = FALSE;

INSERT INTO notification (
    occurrence_id,
    user_id,
    channel,
    destination,
    sent,
    sent_at,
    created_at
)
SELECT
    o.id,
    o.requester_user_id,
    'EMAIL',
    u.email,
    CASE WHEN o.id % 10 <> 0 THEN TRUE ELSE FALSE END,
    CASE WHEN o.id % 10 <> 0 THEN o.created_at + INTERVAL '30 minutes' ELSE NULL END,
    o.created_at + INTERVAL '25 minutes'
FROM occurrence o
JOIN app_user u ON u.id = o.requester_user_id
WHERE o.requester_user_id IS NOT NULL;

INSERT INTO audit_log (
    entity_name,
    entity_id,
    action,
    old_value,
    new_value,
    created_by,
    created_at
)
SELECT
    'occurrence',
    o.id,
    'CREATE',
    NULL,
    jsonb_build_object('protocol', o.protocol, 'origin', o.origin),
    COALESCE(o.requester_user_id::text, 'SYSTEM'),
    o.created_at
FROM occurrence o;