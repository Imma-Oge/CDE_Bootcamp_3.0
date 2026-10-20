
-- Enrich Snapchat advertising performance with the latest ad group history and campaign metadata.

WITH ranked_adgroups AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY snapchat_adgroup_id
            ORDER BY
                snapchat_adgroup_updated_at DESC,
                snapchat_adgroups_surrogate_key DESC
        ) AS row_num
    FROM {{ ref('stg_snapchat_adgroups') }}
),

latest_adgroups AS (
    SELECT *
    FROM ranked_adgroups
    WHERE row_num = 1
)

SELECT
    stats.snapchat_ad_id,
    stats.snapchat_ad_date,
    stats.snapchat_country,
    stats.snapchat_currency_code,
    ads.snapchat_ad_name,
    ads.snapchat_ad_updated_at,
    ads.snapchat_adgroup_id,
    adgroups.snapchat_adgroup_name,
    adgroups.snapchat_adgroup_updated_at,
    adgroups.snapchat_campaign_id,
    campaigns.snapchat_campaign_name,
    campaigns.snapchat_account_id,
    stats.snapchat_spend,
    stats.snapchat_impressions,
    stats.snapchat_clicks

FROM {{ ref('stg_snapchat_ads_stats') }} AS stats

LEFT JOIN {{ ref('stg_snapchat_ads') }} AS ads
    ON stats.snapchat_ad_id = ads.snapchat_ad_id

LEFT JOIN latest_adgroups AS adgroups
    ON ads.snapchat_adgroup_id = adgroups.snapchat_adgroup_id

LEFT JOIN {{ ref('stg_snapchat_campaigns') }} AS campaigns
    ON adgroups.snapchat_campaign_id = campaigns.snapchat_campaign_id
