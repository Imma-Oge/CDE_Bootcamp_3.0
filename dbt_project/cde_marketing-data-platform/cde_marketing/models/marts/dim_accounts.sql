
-- Create a unified advertising account dimension with platform-aware account identifiers.

WITH facebook_accounts AS (
    SELECT
        CONCAT('FB_', CAST(facebook_account_id AS STRING)) AS account_key,
        'Facebook' AS platform,
        CAST(facebook_account_id AS STRING) AS account_id,
        facebook_account_name AS account_name
    FROM {{ ref('int_facebook_performance') }}
),

snapchat_accounts AS (
    SELECT
        CONCAT('SN_', CAST(snapchat_account_id AS STRING)) AS account_key,
        'Snapchat' AS platform,
        CAST(snapchat_account_id AS STRING) AS account_id,
        CAST(NULL AS STRING) AS account_name
    FROM {{ ref('int_snapchat_performance') }}
),

combined AS (
    SELECT * FROM facebook_accounts
    UNION ALL
    SELECT * FROM snapchat_accounts
),

ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY account_key
            ORDER BY account_name DESC NULLS LAST
        ) AS row_num
    FROM combined
)

SELECT
    account_key,
    platform,
    account_id,
    account_name
FROM ranked
WHERE row_num = 1
