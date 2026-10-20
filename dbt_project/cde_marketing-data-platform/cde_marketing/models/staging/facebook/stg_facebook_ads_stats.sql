-- Standardize Facebook advertising performance data while preserving source records and identifiers.

SELECT
    ad_id as facebook_ad_id,
    account_id as facebook_account_id,

    TRY_CAST(NULLIF(LOWER(TRIM(ad_spend)), 'null') AS DECIMAL(18,4)) AS facebook_spend,
    TRY_CAST(NULLIF(LOWER(TRIM(ad_impressions)), 'null') AS BIGINT) AS facebook_impressions,
    TRY_CAST(NULLIF(LOWER(TRIM(ad_clicks)), 'null') AS BIGINT) AS facebook_clicks,
    TRY_CAST(ad_date AS DATE) AS facebook_ad_date,
    TRY_CAST(NULLIF(LOWER(TRIM(_ingested_at)), 'null') AS TIMESTAMP) AS ingested_at,

    _source_file,
    _source_platform,
    _ingestion_run_id
FROM {{ source('raw_marketing_sources', 'facebook_ads_stats') }}