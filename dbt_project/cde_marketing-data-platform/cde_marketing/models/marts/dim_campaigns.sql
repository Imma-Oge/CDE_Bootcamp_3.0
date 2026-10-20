
-- Create a unified campaign dimension with one record per platform-specific campaign.

WITH facebook_campaigns AS (
    SELECT
        CONCAT('FB_', CAST(facebook_campaign_id AS STRING)) AS campaign_key,
        'Facebook' AS platform,
        CAST(facebook_campaign_id AS STRING) AS campaign_id,
        facebook_campaign_name AS campaign_name
    FROM {{ ref('int_facebook_performance') }}
),

snapchat_campaigns AS (
    SELECT
        CONCAT('SN_', CAST(snapchat_campaign_id AS STRING)) AS campaign_key,
        'Snapchat' AS platform,
        CAST(snapchat_campaign_id AS STRING) AS campaign_id,
        snapchat_campaign_name AS campaign_name
    FROM {{ ref('int_snapchat_performance') }}
),

combined AS (
    SELECT * FROM facebook_campaigns
    UNION ALL
    SELECT * FROM snapchat_campaigns
),

ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY campaign_key
            ORDER BY campaign_name DESC NULLS LAST
        ) AS row_num
    FROM combined
)

SELECT
    campaign_key,
    platform,
    campaign_id,
    campaign_name
FROM ranked
WHERE row_num = 1
