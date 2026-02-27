-- Сначала создаем keyspace (важно: создаем ДО роли или после - не имеет значения)
CREATE KEYSPACE IF NOT EXISTS task_management
    WITH REPLICATION = {
        'class': 'SimpleStrategy',
        'replication_factor': 1
        };

-- Создание роли/пользователя
CREATE ROLE IF NOT EXISTS emiasntf
    WITH PASSWORD = 'emiasntf'
     AND LOGIN = true
     AND SUPERUSER = false;

-- Предоставление всех прав пользователю на keyspace
GRANT ALL PERMISSIONS ON KEYSPACE task_management TO emiasntf;

-- Дополнительно: даем права на использование (не обязательно, но полезно)
GRANT CREATE ON ALL KEYSPACES TO emiasntf;  -- Опционально

-- Переключение на созданный keyspace
USE task_management;

CREATE TABLE task_management.task
(
    task_id           UUID,
    event_id          UUID,
    status            TEXT,
    created           TIMESTAMP,
    updated           TIMESTAMP,
    is_completed      BOOLEAN,
    completed_date    TIMESTAMP,
    patient_id        BIGINT,
    event_code        INT,
    notification_text TEXT,
    channel_type_code INT,
    PRIMARY KEY (task_id)
);

CREATE TABLE task_management.ispk_event
(
    ispk_event_id     UUID,
    ispk_event_status TEXT,
    task_id           UUID,
    PRIMARY KEY (ispk_event_id)
);

CREATE INDEX ispk_event_task_id_idx ON task_management.ispk_event (task_id);