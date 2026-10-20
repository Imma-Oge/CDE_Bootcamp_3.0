SELECT
    campaign_id as facebook_campaign_id,

    campaign_name as facebook_campaign_name,
TRY_CAST(NULLIF(LOWER(TRIM(campaign_updated_at)), 'null') AS DATE) AS facebook_campaign_updated_at,
TRY_CAST(NULLIF(LOWER(TRIM(_ingested_at)), 'null') AS TIMESTAMP) AS _ingested_at,

   _ingestion_run_id,
    _source_platform
FROM {{ source('raw_marketing_sources', 'facebook_new_campaign_de_randomized') }}