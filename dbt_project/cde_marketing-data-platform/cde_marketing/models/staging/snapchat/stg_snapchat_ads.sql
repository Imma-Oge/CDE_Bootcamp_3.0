SELECT
    ad_id as snapchat_ad_id,
    ad_group_id as snapchat_adgroup_id,
    ad_name as snapchat_ad_name,
    TRY_CAST(NULLIF(LOWER(TRIM(ad_detail_updated_at)), 'null') AS TIMESTAMP) AS snapchat_ad_updated_at,

    TRY_CAST(NULLIF(LOWER(TRIM(_ingested_at)), 'null') AS TIMESTAMP) AS ingested_at,
    _source_file,
    _ingestion_run_id,
    _source_platform
FROM {{ source('raw_marketing_sources', 'snapchat_ads_ad_history_new_ad_names') }}