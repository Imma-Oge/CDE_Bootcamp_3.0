-- Enrich Facebook advertising performance with ad, ad group, campaign, and account information.

SELECT
    stats.facebook_ad_id,
    stats.facebook_ad_date,
    ads.facebook_ad_name,
    ads.facebook_ad_status,
    ads.facebook_ad_updated_at,
    ads.facebook_adgroup_id,
    stats.facebook_account_id,
    adgroups.facebook_adgroup_name,
    campaigns.facebook_campaign_name,
    ads.facebook_campaign_id,
    accounts.facebook_account_name,
    accounts.facebook_currency_code,
    stats.facebook_spend,
    stats.facebook_impressions,
    stats.facebook_clicks

FROM {{ ref('stg_facebook_ads_stats') }} AS stats

LEFT JOIN {{ ref('stg_facebook_ads') }} AS ads
    ON stats.facebook_ad_id = ads.facebook_ad_id

LEFT JOIN {{ ref('stg_facebook_adgroups') }} AS adgroups
    ON ads.facebook_adgroup_id = adgroups.facebook_adgroup_id

LEFT JOIN {{ ref('stg_facebook_campaigns') }} AS campaigns
    ON ads.facebook_campaign_id = campaigns.facebook_campaign_id

LEFT JOIN {{ ref('stg_facebook_accounts') }} AS accounts
    ON stats.facebook_account_id = accounts.facebook_account_id