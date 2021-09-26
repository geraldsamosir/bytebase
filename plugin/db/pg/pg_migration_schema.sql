-- This is the bytebase schema to track migration info for Postgres
-- Create a database called bytebase in the driver.
-- CREATE DATABASE bytebase;

CREATE TABLE setting (
    id SERIAL PRIMARY KEY,
    created_by TEXT NOT NULL,
    created_ts BIGINT NOT NULL,
    updated_by TEXT NOT NULL,
    updated_ts BIGINT NOT NULL,
    name TEXT NOT NULL,
    value TEXT NOT NULL,
    description TEXT NOT NULL
);

CREATE UNIQUE INDEX bytebase_idx_unique_setting_name ON setting (name(256));

-- Insert schema version 1
INSERT INTO
    setting (
        created_by,
        created_ts,
        updated_by,
        updated_ts,
        name,
        value,
        description
    )
VALUES
    (
        'bytebase',
        EXTRACT(epoch from NOW()),
        'bytebase',
        EXTRACT(epoch FROM NOW()),
        'bb.schema.version',
        '1',
        'Schema version'
    );

-- Create migration_history table
-- Note, we don't create trigger to update created_ts and updated_ts because that may causes error:
-- ERROR 1419 (HY000): You do not have the SUPER privilege and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)
CREATE TABLE migration_history (
    id SERIAL PRIMARY KEY,
    created_by TEXT NOT NULL,
    created_ts BIGINT NOT NULL,
    updated_by TEXT NOT NULL,
    updated_ts BIGINT NOT NULL,
    -- Allows granular tracking of migration history (e.g If an application manages schemas for a multi-tenant service and each tenant has its own schema, that application can use namespace to record the tenant name to track the per-tenant schema migration)
    -- Since bytebase also manages different application databases from an instance, it leverages this field to track each database migration history.
    namespace TEXT NOT NULL,
    -- Used to detect out of order migration together with 'namespace' and 'version' column.
    sequence INTEGER NOT NULL CHECK (sequence >= 0),
    -- We call it engine because maybe we could load history from other migration tool.
    engine TEXT NOT NULL CHECK (engine in ('UI', 'VCS')),
    type TEXT NOT NULL CHECK (type in ('BASELINE', 'MIGRATE', 'BRANCH')),
    -- MySQL runs DDL in its own transaction, so we can't record DDL and migration_history into a single transaction.
    -- Thus, we create a "PENDING" record before applying the DDL and update that record to "DONE" after applying the DDL.
    status TEXT NOT NULL CHECK (status in ('PENDING', 'DONE')),
    version TEXT NOT NULL,
    description TEXT NOT NULL,
    -- Record the migration statement
    statement TEXT NOT NULL,
    -- Record the schema after migration
    schema TEXT NOT NULL,
    execution_duration INTEGER NOT NULL,
    issue_id TEXT NOT NULL,
    payload TEXT NOT NULL
);

CREATE UNIQUE INDEX bytebase_idx_unique_migration_history_namespace_sequence ON migration_history (namespace, sequence);

CREATE UNIQUE INDEX bytebase_idx_unique_migration_history_namespace_engine_version ON migration_history (namespace, engine, version);

CREATE INDEX bytebase_idx_migration_history_namespace_engine_type ON migration_history(namespace, engine, type);

CREATE INDEX bytebase_idx_migration_history_namespace_created ON migration_history(namespace, created_ts);