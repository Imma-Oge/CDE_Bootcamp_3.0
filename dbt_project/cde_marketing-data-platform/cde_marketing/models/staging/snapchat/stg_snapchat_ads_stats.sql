SELECT
    ad_detail_id as snapchat_ad_id,
    ad_currency_code as snapchat_currency_code,

    ad_country as snapchat_country,
    ad_spend as snapchat_spend,
    ad_impressions as snapchat_impressions,
    ad_clicks as snapchat_clicks,
    data_src as snapchat_data_source,
    TRY_CAST(NULLIF(LOWER(TRIM(ad_date)), 'null') AS DATE) AS snapchat_ad_date,

    TRY_CAST(NULLIF(LOWER(TRIM(_ingested_at)), 'null') AS TIMESTAMP) AS ingested_at,
    _source_file,
    _ingestion_run_id,
    _source_platform
FROM {{ source('raw_marketing_sources', 'snapchat_ads_stats') }}