INSERT INTO bairros (nome) VALUES
('Centro'),
('Costa Azul'),
('Jardim Mariléa'),
('Âncora'),
('Nova Cidade'),
('Village'),
('Operário'),
('Extensão do Bosque'),
('Cidade Praiana'),
('Mar do Norte');

INSERT INTO categorias (nome) VALUES
('Buraco na via'),
('Iluminação pública'),
('Lixo acumulado'),
('Esgoto a céu aberto'),
('Sinalização danificada'),
('Árvore caída'),
('Alagamento'),
('Calçada danificada');

INSERT INTO status_ocorrencia (nome) VALUES
('Aberta'),
('Em análise'),
('Em atendimento'),
('Resolvida'),
('Cancelada');

INSERT INTO usuarios (nome, email) VALUES
('Ana Souza', 'ana.souza@email.com'),
('Bruno Lima', 'bruno.lima@email.com'),
('Carlos Mendes', 'carlos.mendes@email.com'),
('Daniela Rocha', 'daniela.rocha@email.com'),
('Eduardo Nunes', 'eduardo.nunes@email.com');

INSERT INTO equipes (nome, ativa) VALUES
('Equipe Pavimentação', TRUE),
('Equipe Iluminação', TRUE),
('Equipe Limpeza Urbana', TRUE),
('Equipe Defesa Civil', TRUE),
('Equipe Inativa Teste', FALSE);



INSERT INTO ocorrencias (
    protocolo,
    titulo,
    descricao,
    bairro_id,
    categoria_id,
    usuario_id,
    latitude,
    longitude,
    criada_em
) VALUES
('OTP-2026-0001', 'Buraco grande próximo à praça', 'Buraco causando risco para veículos.', 1, 1, 1, -22.5261000, -41.9452000, CURRENT_TIMESTAMP - INTERVAL '15 days'),
('OTP-2026-0002', 'Poste apagado na rua principal', 'Iluminação pública sem funcionar há três dias.', 2, 2, 2, -22.5200000, -41.9300000, CURRENT_TIMESTAMP - INTERVAL '8 days'),
('OTP-2026-0003', 'Lixo acumulado próximo ao mercado', 'Grande quantidade de lixo na calçada.', 3, 3, 3, -22.5100000, -41.9200000, CURRENT_TIMESTAMP - INTERVAL '5 days'),
('OTP-2026-0004', 'Esgoto vazando na rua', 'Mau cheiro e água escorrendo pela via.', 4, 4, NULL, -22.5000000, -41.9100000, CURRENT_TIMESTAMP - INTERVAL '20 days'),
('OTP-2026-0005', 'Placa de trânsito caída', 'Placa de pare caída após temporal.', 5, 5, 4, -22.4900000, -41.9000000, CURRENT_TIMESTAMP - INTERVAL '2 days'),
('OTP-2026-0006', 'Árvore bloqueando passagem', 'Galho grande bloqueando parte da rua.', 6, 6, 5, -22.4800000, -41.8900000, CURRENT_TIMESTAMP - INTERVAL '1 day'),
('OTP-2026-0007', 'Rua alagada após chuva', 'Água acumulada impedindo passagem de pedestres.', 7, 7, 1, -22.4700000, -41.8800000, CURRENT_TIMESTAMP - INTERVAL '12 days'),
('OTP-2026-0008', 'Calçada quebrada perto da escola', 'Risco de queda para pedestres.', 8, 8, 2, -22.4600000, -41.8700000, CURRENT_TIMESTAMP - INTERVAL '3 days'),
('OTP-2026-0009', 'Buraco pequeno aumentando', 'Buraco crescendo no meio da via.', 1, 1, 3, -22.5265000, -41.9460000, CURRENT_TIMESTAMP - INTERVAL '30 days'),
('OTP-2026-0010', 'Lâmpada piscando', 'Poste com lâmpada piscando à noite.', 2, 2, NULL, -22.5210000, -41.9310000, CURRENT_TIMESTAMP - INTERVAL '6 hours');


INSERT INTO fotos_ocorrencia (ocorrencia_id, url, criada_em) VALUES
(1, 'https://storage.fake/otp/0001-1.jpg', CURRENT_TIMESTAMP - INTERVAL '15 days'),
(1, 'https://storage.fake/otp/0001-2.jpg', CURRENT_TIMESTAMP - INTERVAL '15 days'),
(2, 'https://storage.fake/otp/0002-1.jpg', CURRENT_TIMESTAMP - INTERVAL '8 days'),
(3, 'https://storage.fake/otp/0003-1.jpg', CURRENT_TIMESTAMP - INTERVAL '5 days'),
(5, 'https://storage.fake/otp/0005-1.jpg', CURRENT_TIMESTAMP - INTERVAL '2 days'),
(7, 'https://storage.fake/otp/0007-1.jpg', CURRENT_TIMESTAMP - INTERVAL '12 days'),
(8, 'https://storage.fake/otp/0008-1.jpg', CURRENT_TIMESTAMP - INTERVAL '3 days'),
(9, 'https://storage.fake/otp/0009-1.jpg', CURRENT_TIMESTAMP - INTERVAL '30 days');


INSERT INTO historico_status_ocorrencia (ocorrencia_id, status_id, observacao, alterado_em) VALUES
(1, 1, 'Ocorrência registrada.', CURRENT_TIMESTAMP - INTERVAL '15 days'),
(1, 2, 'Encaminhada para análise.', CURRENT_TIMESTAMP - INTERVAL '14 days'),
(1, 3, 'Equipe acionada.', CURRENT_TIMESTAMP - INTERVAL '10 days'),

(2, 1, 'Ocorrência registrada.', CURRENT_TIMESTAMP - INTERVAL '8 days'),
(2, 2, 'Validação inicial realizada.', CURRENT_TIMESTAMP - INTERVAL '7 days'),

(3, 1, 'Ocorrência registrada.', CURRENT_TIMESTAMP - INTERVAL '5 days'),
(3, 3, 'Limpeza urbana acionada.', CURRENT_TIMESTAMP - INTERVAL '4 days'),
(3, 4, 'Problema resolvido.', CURRENT_TIMESTAMP - INTERVAL '2 days'),

(4, 1, 'Ocorrência anônima registrada.', CURRENT_TIMESTAMP - INTERVAL '20 days'),
(4, 2, 'Necessária vistoria.', CURRENT_TIMESTAMP - INTERVAL '18 days'),

(5, 1, 'Ocorrência registrada.', CURRENT_TIMESTAMP - INTERVAL '2 days'),

(6, 1, 'Ocorrência registrada.', CURRENT_TIMESTAMP - INTERVAL '1 day'),
(6, 4, 'Galho removido.', CURRENT_TIMESTAMP - INTERVAL '12 hours'),

(7, 1, 'Ocorrência registrada.', CURRENT_TIMESTAMP - INTERVAL '12 days'),
(7, 2, 'Em avaliação pela Defesa Civil.', CURRENT_TIMESTAMP - INTERVAL '11 days'),
(7, 5, 'Cancelada por duplicidade.', CURRENT_TIMESTAMP - INTERVAL '9 days'),

(8, 1, 'Ocorrência registrada.', CURRENT_TIMESTAMP - INTERVAL '3 days'),
(8, 2, 'Análise pendente.', CURRENT_TIMESTAMP - INTERVAL '2 days'),

(9, 1, 'Ocorrência registrada.', CURRENT_TIMESTAMP - INTERVAL '30 days'),
(9, 3, 'Equipe de pavimentação acionada.', CURRENT_TIMESTAMP - INTERVAL '25 days'),

(10, 1, 'Ocorrência registrada.', CURRENT_TIMESTAMP - INTERVAL '6 hours');

INSERT INTO atribuicoes_ocorrencia (ocorrencia_id, equipe_id, atribuida_em, encerrada_em) VALUES
(1, 1, CURRENT_TIMESTAMP - INTERVAL '10 days', NULL),
(2, 2, CURRENT_TIMESTAMP - INTERVAL '7 days', NULL),
(3, 3, CURRENT_TIMESTAMP - INTERVAL '4 days', CURRENT_TIMESTAMP - INTERVAL '2 days'),
(6, 4, CURRENT_TIMESTAMP - INTERVAL '20 hours', CURRENT_TIMESTAMP - INTERVAL '12 hours'),
(7, 4, CURRENT_TIMESTAMP - INTERVAL '11 days', CURRENT_TIMESTAMP - INTERVAL '9 days'),
(9, 1, CURRENT_TIMESTAMP - INTERVAL '25 days', NULL);








