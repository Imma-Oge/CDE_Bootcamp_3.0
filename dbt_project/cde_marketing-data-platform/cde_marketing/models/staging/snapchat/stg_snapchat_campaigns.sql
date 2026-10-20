SELECT
    campaign_id as snapchat_campaign_id,
    account_id as snapchat_account_id,
    campaign_name as snapchat_campaign_name,
    TRY_CAST(NULLIF(LOWER(TRIM(_ingested_at)), 'null') AS TIMESTAMP) AS ingested_at,
    _source_file,
    _ingestion_run_id,
    _source_platform
FROM {{ source('raw_marketing_sources', 'snapchat_ads_campaign_history_new_campaign_names') }}