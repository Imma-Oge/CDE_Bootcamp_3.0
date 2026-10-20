
-- Combine Facebook and Snapchat performance into a unified fact table while preserving source grain and currencies.

WITH facebook_performance AS (
    SELECT
        'Facebook' AS platform,
        CONCAT('FB_', CAST(facebook_ad_id AS STRING)) AS ad_key,
        CONCAT('FB_', CAST(facebook_adgroup_id AS STRING)) AS adgroup_key,
        CONCAT('FB_', CAST(facebook_campaign_id AS STRING)) AS campaign_key,
        CONCAT('FB_', CAST(facebook_account_id AS STRING)) AS account_key,
        facebook_ad_date AS ad_date,
        CAST(NULL AS STRING) AS country,
        facebook_currency_code AS currency_code,
        TRY_CAST(facebook_spend AS DECIMAL(18,4)) AS spend,
        TRY_CAST(facebook_impressions AS BIGINT) AS impressions,
        TRY_CAST(facebook_clicks AS BIGINT) AS clicks
    FROM {{ ref('int_facebook_performance') }}
),

snapchat_performance AS (
    SELECT
        'Snapchat' AS platform,
        CONCAT('SN_', CAST(snapchat_ad_id AS STRING)) AS ad_key,
        CONCAT('SN_', CAST(snapchat_adgroup_id AS STRING)) AS adgroup_key,
        CONCAT('SN_', CAST(snapchat_campaign_id AS STRING)) AS campaign_key,
        CONCAT('SN_', CAST(snapchat_account_id AS STRING)) AS account_key,
        snapchat_ad_date AS ad_date,
        snapchat_country AS country,
        snapchat_currency_code AS currency_code,
        TRY_CAST(snapchat_spend AS DECIMAL(18,4)) AS spend,
        TRY_CAST(snapchat_impressions AS BIGINT) AS impressions,
        TRY_CAST(snapchat_clicks AS BIGINT) AS clicks
    FROM {{ ref('int_snapchat_performance') }}
)

SELECT * FROM facebook_performance
UNION ALL
SELECT * FROM snapchat_performance
