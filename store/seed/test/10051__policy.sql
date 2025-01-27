INSERT INTO
    policy (
        id,
        creator_id,
        updater_id,
        environment_id,
        type,
        payload
    )
VALUES
    (
        5101,
        101,
        101,
        5001,
        'bb.policy.pipeline-approval',
        '{"value":"MANUAL_APPROVAL_NEVER"}'
    );

INSERT INTO
    policy (
        creator_id,
        updater_id,
        environment_id,
        type,
        payload
    )
VALUES
    (
        101,
        101,
        5002,
        'bb.policy.pipeline-approval',
        '{"value":"MANUAL_APPROVAL_NEVER"}'
    );

INSERT INTO
    policy (
        creator_id,
        updater_id,
        environment_id,
        type,
        payload
    )
VALUES
    (
        101,
        101,
        5003,
        'bb.policy.pipeline-approval',
        '{"value":"MANUAL_APPROVAL_ALWAYS"}'
    );

INSERT INTO
    policy (
        creator_id,
        updater_id,
        environment_id,
        type,
        payload
    )
VALUES
    (
        101,
        101,
        5004,
        'bb.policy.pipeline-approval',
        '{"value":"MANUAL_APPROVAL_NEVER"}'
    );

INSERT INTO
    policy (
        creator_id,
        updater_id,
        environment_id,
        type,
        payload
    )
VALUES
    (
        101,
        101,
        5005,
        'bb.policy.pipeline-approval',
        '{"value":"MANUAL_APPROVAL_NEVER"}'
    );

INSERT INTO
    policy (
        creator_id,
        updater_id,
        environment_id,
        type,
        payload
    )
VALUES
    (
        101,
        101,
        5003,
        'bb.policy.backup-plan',
        '{"schedule":"WEEKLY"}'
    );

INSERT INTO
    policy (
        creator_id,
        updater_id,
        environment_id,
        type,
        payload
    )
VALUES
    (
        101,
        101,
        5004,
        'bb.policy.backup-plan',
        '{"schedule":"DAILY"}'
    );

-- Test upsert.
INSERT INTO
    policy (
        creator_id,
        updater_id,
        environment_id,
        type,
        payload
    )
VALUES
    (
        101,
        101,
        5004,
        'bb.policy.pipeline-approval',
        '{"value":"MANUAL_APPROVAL_ALWAYS"}'
    )
    ON CONFLICT(environment_id, type) DO UPDATE SET
				payload = excluded.payload;
