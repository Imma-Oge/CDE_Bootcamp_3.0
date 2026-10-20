
-- Create a unified ad group dimension with platform-aware keys and deduplicated metadata.

WITH facebook_adgroups AS (
    SELECT
        CONCAT('FB_', CAST(facebook_adgroup_id AS STRING)) AS adgroup_key,
        'Facebook' AS platform,
        CAST(facebook_adgroup_id AS STRING) AS adgroup_id,
        facebook_adgroup_name AS adgroup_name,
        CAST(NULL AS TIMESTAMP) AS adgroup_updated_at
    FROM {{ ref('int_facebook_performance') }}
),

snapchat_adgroups AS (
    SELECT
        CONCAT('SN_', CAST(snapchat_adgroup_id AS STRING)) AS adgroup_key,
        'Snapchat' AS platform,
        CAST(snapchat_adgroup_id AS STRING) AS adgroup_id,
        snapchat_adgroup_name AS adgroup_name,
        snapchat_adgroup_updated_at AS adgroup_updated_at
    FROM {{ ref('int_snapchat_performance') }}
),

combined AS (
    SELECT * FROM facebook_adgroups
    UNION ALL
    SELECT * FROM snapchat_adgroups
),

ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY adgroup_key
            ORDER BY adgroup_updated_at DESC NULLS LAST, adgroup_name DESC NULLS LAST
        ) AS row_num
    FROM combined
)

SELECT
    adgroup_key,
    platform,
    adgroup_id,
    adgroup_name,
    adgroup_updated_at
FROM ranked
WHERE row_num = 1
