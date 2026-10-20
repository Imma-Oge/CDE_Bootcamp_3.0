
-- Create a unified advertising dimension with one latest record per platform-specific ad.

WITH facebook_ads AS (
    SELECT
        CONCAT('FB_', CAST(facebook_ad_id AS STRING)) AS ad_key,
        'Facebook' AS platform,
        CAST(facebook_ad_id AS STRING) AS ad_id,
        facebook_ad_name AS ad_name,
        facebook_ad_status AS ad_status,
        facebook_ad_updated_at AS ad_updated_at
    FROM {{ ref('int_facebook_performance') }}
),

snapchat_ads AS (
    SELECT
        CONCAT('SN_', CAST(snapchat_ad_id AS STRING)) AS ad_key,
        'Snapchat' AS platform,
        CAST(snapchat_ad_id AS STRING) AS ad_id,
        snapchat_ad_name AS ad_name,
        CAST(NULL AS STRING) AS ad_status,
        snapchat_ad_updated_at AS ad_updated_at
    FROM {{ ref('int_snapchat_performance') }}
),

combined AS (
    SELECT * FROM facebook_ads
    UNION ALL
    SELECT * FROM snapchat_ads
),

ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY ad_key
            ORDER BY ad_updated_at DESC NULLS LAST, ad_name DESC NULLS LAST, ad_status DESC NULLS LAST
        ) AS row_num
    FROM combined
)

SELECT
    ad_key,
    platform,
    ad_id,
    ad_name,
    ad_status,
    ad_updated_at
FROM ranked
WHERE row_num = 1
