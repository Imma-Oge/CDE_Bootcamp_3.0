SELECT
    _surrogate_key as snapchat_adgroups_surrogate_key,
    ad_group_id as snapchat_adgroup_id,
    campaign_id as snapchat_campaign_id,
    ad_group_name as snapchat_adgroup_name,
    TRY_CAST(NULLIF(LOWER(TRIM(ad_group_updated_at)), 'null') AS TIMESTAMP) AS snapchat_adgroup_updated_at,
    TRY_CAST(NULLIF(LOWER(TRIM(_ingested_at)), 'null') AS TIMESTAMP) AS ingested_at,
    _source_file,
    _ingestion_run_id,
    _source_platform
FROM {{ source('raw_marketing_sources', 'snapchat_ads_adgroup_history_new_ad_group_names') }}