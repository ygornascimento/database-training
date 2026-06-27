DROP TABLE IF EXISTS audit_log CASCADE;
DROP TABLE IF EXISTS notification CASCADE;
DROP TABLE IF EXISTS integration_error CASCADE;
DROP TABLE IF EXISTS integration_message CASCADE;
DROP TABLE IF EXISTS external_protocol_map CASCADE;
DROP TABLE IF EXISTS service_order_event CASCADE;
DROP TABLE IF EXISTS service_order CASCADE;
DROP TABLE IF EXISTS occurrence_assignment CASCADE;
DROP TABLE IF EXISTS team_member CASCADE;
DROP TABLE IF EXISTS field_team CASCADE;
DROP TABLE IF EXISTS occurrence_status_history CASCADE;
DROP TABLE IF EXISTS occurrence_attachment CASCADE;
DROP TABLE IF EXISTS occurrence_comment CASCADE;
DROP TABLE IF EXISTS occurrence CASCADE;
DROP TABLE IF EXISTS sla_policy CASCADE;
DROP TABLE IF EXISTS priority CASCADE;
DROP TABLE IF EXISTS occurrence_status CASCADE;
DROP TABLE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS department CASCADE;
DROP TABLE IF EXISTS app_user_role CASCADE;
DROP TABLE IF EXISTS app_role CASCADE;
DROP TABLE IF EXISTS app_user CASCADE;
DROP TABLE IF EXISTS address CASCADE;
DROP TABLE IF EXISTS district CASCADE;
DROP TABLE IF EXISTS city CASCADE;
DROP TABLE IF EXISTS integration_source CASCADE;

CREATE TABLE city (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    state_code CHAR(2) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE district (
    id BIGSERIAL PRIMARY KEY,
    city_id BIGINT NOT NULL,
    name VARCHAR(120) NOT NULL,
    legacy_code VARCHAR(30),

    CONSTRAINT fk_district_city
        FOREIGN KEY (city_id) REFERENCES city(id)
);

CREATE TABLE address (
    id BIGSERIAL PRIMARY KEY,
    district_id BIGINT NOT NULL,
    street VARCHAR(160) NOT NULL,
    number VARCHAR(20),
    complement VARCHAR(120),
    postal_code VARCHAR(20),
    latitude NUMERIC(10, 7),
    longitude NUMERIC(10, 7),

    CONSTRAINT fk_address_district
        FOREIGN KEY (district_id) REFERENCES district(id)
);

CREATE TABLE app_user (
    id BIGSERIAL PRIMARY KEY,
    full_name VARCHAR(140) NOT NULL,
    email VARCHAR(180) UNIQUE,
    document_number VARCHAR(30),
    phone VARCHAR(40),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE app_role (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE app_user_role (
    user_id BIGINT NOT NULL,
    role_id BIGINT NOT NULL,

    PRIMARY KEY (user_id, role_id),

    CONSTRAINT fk_app_user_role_user
        FOREIGN KEY (user_id) REFERENCES app_user(id),

    CONSTRAINT fk_app_user_role_role
        FOREIGN KEY (role_id) REFERENCES app_role(id)
);

CREATE TABLE department (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(120) NOT NULL UNIQUE,
    acronym VARCHAR(20),
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE category (
    id BIGSERIAL PRIMARY KEY,
    department_id BIGINT NOT NULL,
    name VARCHAR(120) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_category_department
        FOREIGN KEY (department_id) REFERENCES department(id)
);

CREATE TABLE occurrence_status (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(80) NOT NULL UNIQUE,
    is_final BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE priority (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    weight INTEGER NOT NULL
);

CREATE TABLE sla_policy (
    id BIGSERIAL PRIMARY KEY,
    category_id BIGINT NOT NULL,
    priority_id BIGINT NOT NULL,
    max_hours INTEGER NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_sla_policy_category
        FOREIGN KEY (category_id) REFERENCES category(id),

    CONSTRAINT fk_sla_policy_priority
        FOREIGN KEY (priority_id) REFERENCES priority(id)
);

CREATE TABLE occurrence (
    id BIGSERIAL PRIMARY KEY,
    protocol VARCHAR(40) NOT NULL UNIQUE,
    external_code VARCHAR(80),
    title VARCHAR(160) NOT NULL,
    description TEXT NOT NULL,
    category_id BIGINT NOT NULL,
    address_id BIGINT NOT NULL,
    requester_user_id BIGINT,
    priority_id BIGINT NOT NULL,
    origin VARCHAR(40) NOT NULL DEFAULT 'APP',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    canceled_at TIMESTAMP,

    CONSTRAINT fk_occurrence_category
        FOREIGN KEY (category_id) REFERENCES category(id),

    CONSTRAINT fk_occurrence_address
        FOREIGN KEY (address_id) REFERENCES address(id),

    CONSTRAINT fk_occurrence_requester
        FOREIGN KEY (requester_user_id) REFERENCES app_user(id),

    CONSTRAINT fk_occurrence_priority
        FOREIGN KEY (priority_id) REFERENCES priority(id)
);

CREATE TABLE occurrence_comment (
    id BIGSERIAL PRIMARY KEY,
    occurrence_id BIGINT NOT NULL,
    user_id BIGINT,
    comment_text TEXT NOT NULL,
    internal_only BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_occurrence_comment_occurrence
        FOREIGN KEY (occurrence_id) REFERENCES occurrence(id),

    CONSTRAINT fk_occurrence_comment_user
        FOREIGN KEY (user_id) REFERENCES app_user(id)
);

CREATE TABLE occurrence_attachment (
    id BIGSERIAL PRIMARY KEY,
    occurrence_id BIGINT NOT NULL,
    file_url TEXT NOT NULL,
    file_type VARCHAR(40),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_occurrence_attachment_occurrence
        FOREIGN KEY (occurrence_id) REFERENCES occurrence(id)
);

CREATE TABLE occurrence_status_history (
    id BIGSERIAL PRIMARY KEY,
    occurrence_id BIGINT NOT NULL,
    status_id BIGINT NOT NULL,
    changed_by_user_id BIGINT,
    note TEXT,
    changed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_occurrence_status_history_occurrence
        FOREIGN KEY (occurrence_id) REFERENCES occurrence(id),

    CONSTRAINT fk_occurrence_status_history_status
        FOREIGN KEY (status_id) REFERENCES occurrence_status(id),

    CONSTRAINT fk_occurrence_status_history_user
        FOREIGN KEY (changed_by_user_id) REFERENCES app_user(id)
);

CREATE TABLE field_team (
    id BIGSERIAL PRIMARY KEY,
    department_id BIGINT NOT NULL,
    name VARCHAR(120) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_field_team_department
        FOREIGN KEY (department_id) REFERENCES department(id)
);

CREATE TABLE team_member (
    id BIGSERIAL PRIMARY KEY,
    team_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    leader BOOLEAN NOT NULL DEFAULT FALSE,
    active BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_team_member_team
        FOREIGN KEY (team_id) REFERENCES field_team(id),

    CONSTRAINT fk_team_member_user
        FOREIGN KEY (user_id) REFERENCES app_user(id)
);

CREATE TABLE occurrence_assignment (
    id BIGSERIAL PRIMARY KEY,
    occurrence_id BIGINT NOT NULL,
    team_id BIGINT NOT NULL,
    assigned_by_user_id BIGINT,
    assigned_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    closed_at TIMESTAMP,

    CONSTRAINT fk_occurrence_assignment_occurrence
        FOREIGN KEY (occurrence_id) REFERENCES occurrence(id),

    CONSTRAINT fk_occurrence_assignment_team
        FOREIGN KEY (team_id) REFERENCES field_team(id),

    CONSTRAINT fk_occurrence_assignment_user
        FOREIGN KEY (assigned_by_user_id) REFERENCES app_user(id)
);

CREATE TABLE service_order (
    id BIGSERIAL PRIMARY KEY,
    occurrence_id BIGINT NOT NULL,
    order_number VARCHAR(40) NOT NULL UNIQUE,
    team_id BIGINT,
    opened_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    closed_at TIMESTAMP,
    result_note TEXT,

    CONSTRAINT fk_service_order_occurrence
        FOREIGN KEY (occurrence_id) REFERENCES occurrence(id),

    CONSTRAINT fk_service_order_team
        FOREIGN KEY (team_id) REFERENCES field_team(id)
);

CREATE TABLE service_order_event (
    id BIGSERIAL PRIMARY KEY,
    service_order_id BIGINT NOT NULL,
    event_type VARCHAR(80) NOT NULL,
    event_note TEXT,
    event_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_service_order_event_order
        FOREIGN KEY (service_order_id) REFERENCES service_order(id)
);

CREATE TABLE integration_source (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE external_protocol_map (
    id BIGSERIAL PRIMARY KEY,
    occurrence_id BIGINT NOT NULL,
    source_id BIGINT NOT NULL,
    external_protocol VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_external_protocol_map_occurrence
        FOREIGN KEY (occurrence_id) REFERENCES occurrence(id),

    CONSTRAINT fk_external_protocol_map_source
        FOREIGN KEY (source_id) REFERENCES integration_source(id)
);

CREATE TABLE integration_message (
    id BIGSERIAL PRIMARY KEY,
    source_id BIGINT NOT NULL,
    occurrence_id BIGINT,
    external_protocol VARCHAR(100),
    payload JSONB NOT NULL,
    processed BOOLEAN NOT NULL DEFAULT FALSE,
    processed_at TIMESTAMP,
    received_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_integration_message_source
        FOREIGN KEY (source_id) REFERENCES integration_source(id),

    CONSTRAINT fk_integration_message_occurrence
        FOREIGN KEY (occurrence_id) REFERENCES occurrence(id)
);

CREATE TABLE integration_error (
    id BIGSERIAL PRIMARY KEY,
    integration_message_id BIGINT NOT NULL,
    error_code VARCHAR(80) NOT NULL,
    error_message TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_integration_error_message
        FOREIGN KEY (integration_message_id) REFERENCES integration_message(id)
);

CREATE TABLE notification (
    id BIGSERIAL PRIMARY KEY,
    occurrence_id BIGINT,
    user_id BIGINT,
    channel VARCHAR(40) NOT NULL,
    destination VARCHAR(180),
    sent BOOLEAN NOT NULL DEFAULT FALSE,
    sent_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_notification_occurrence
        FOREIGN KEY (occurrence_id) REFERENCES occurrence(id),

    CONSTRAINT fk_notification_user
        FOREIGN KEY (user_id) REFERENCES app_user(id)
);

CREATE TABLE audit_log (
    id BIGSERIAL PRIMARY KEY,
    entity_name VARCHAR(120) NOT NULL,
    entity_id BIGINT NOT NULL,
    action VARCHAR(80) NOT NULL,
    old_value JSONB,
    new_value JSONB,
    created_by VARCHAR(120),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_district_city_id ON district(city_id);
CREATE INDEX idx_address_district_id ON address(district_id);

CREATE INDEX idx_category_department_id ON category(department_id);
CREATE INDEX idx_occurrence_category_id ON occurrence(category_id);
CREATE INDEX idx_occurrence_address_id ON occurrence(address_id);
CREATE INDEX idx_occurrence_requester_user_id ON occurrence(requester_user_id);
CREATE INDEX idx_occurrence_priority_id ON occurrence(priority_id);
CREATE INDEX idx_occurrence_created_at ON occurrence(created_at);
CREATE INDEX idx_occurrence_external_code ON occurrence(external_code);

CREATE INDEX idx_occurrence_attachment_occurrence_id ON occurrence_attachment(occurrence_id);
CREATE INDEX idx_occurrence_comment_occurrence_id ON occurrence_comment(occurrence_id);

CREATE INDEX idx_occurrence_status_history_occurrence_id ON occurrence_status_history(occurrence_id);
CREATE INDEX idx_occurrence_status_history_status_id ON occurrence_status_history(status_id);
CREATE INDEX idx_occurrence_status_history_changed_at ON occurrence_status_history(changed_at);

CREATE INDEX idx_field_team_department_id ON field_team(department_id);
CREATE INDEX idx_team_member_team_id ON team_member(team_id);
CREATE INDEX idx_team_member_user_id ON team_member(user_id);

CREATE INDEX idx_occurrence_assignment_occurrence_id ON occurrence_assignment(occurrence_id);
CREATE INDEX idx_occurrence_assignment_team_id ON occurrence_assignment(team_id);

CREATE INDEX idx_service_order_occurrence_id ON service_order(occurrence_id);
CREATE INDEX idx_service_order_team_id ON service_order(team_id);
CREATE INDEX idx_service_order_event_order_id ON service_order_event(service_order_id);

CREATE INDEX idx_external_protocol_map_occurrence_id ON external_protocol_map(occurrence_id);
CREATE INDEX idx_external_protocol_map_source_id ON external_protocol_map(source_id);
CREATE INDEX idx_external_protocol_map_external_protocol ON external_protocol_map(external_protocol);

CREATE INDEX idx_integration_message_source_id ON integration_message(source_id);
CREATE INDEX idx_integration_message_occurrence_id ON integration_message(occurrence_id);
CREATE INDEX idx_integration_message_external_protocol ON integration_message(external_protocol);
CREATE INDEX idx_integration_message_received_at ON integration_message(received_at);
CREATE INDEX idx_integration_message_processed ON integration_message(processed);

CREATE INDEX idx_integration_error_message_id ON integration_error(integration_message_id);

CREATE INDEX idx_notification_occurrence_id ON notification(occurrence_id);
CREATE INDEX idx_notification_user_id ON notification(user_id);
CREATE INDEX idx_notification_sent ON notification(sent);

CREATE INDEX idx_audit_log_entity ON audit_log(entity_name, entity_id);