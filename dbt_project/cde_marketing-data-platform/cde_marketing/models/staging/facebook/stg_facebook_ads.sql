SELECT
    ad_id as facebook_ad_id,
    campaign_id as facebook_campaign_id,
    ad_group_id as facebook_adgroup_id,
    account_id as facebook_account_id,
    ad_name as facebook_ad_name,
    ad_status as facebook_ad_status,
    TRY_CAST(NULLIF(LOWER(TRIM(ad_updated_at)), 'null') AS DATE) AS facebook_ad_updated_at,

    TRY_CAST(NULLIF(LOWER(TRIM(_ingested_at)), 'null') AS TIMESTAMP) AS ingested_at,
    _source_file,
    _ingestion_run_id,
    _source_platform
FROM {{ source('raw_marketing_sources', 'facebook_new_ads_de_randomized') }}