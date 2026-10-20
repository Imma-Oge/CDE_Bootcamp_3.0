

SELECT
    account_id as facebook_account_id,
    account_name as facebook_account_name,
    UPPER(TRIM(ad_currency_code)) as facebook_currency_code,
    TRY_CAST(NULLIF(LOWER(TRIM(account_created_at)), 'null') AS DATE) AS facebook_account_created_at,
    TRY_CAST(NULLIF(LOWER(TRIM(account_updated_at)), 'null') AS DATE) AS facebook_account_updated_at,
    TRY_CAST(NULLIF(LOWER(TRIM(_ingested_at)), 'null') AS TIMESTAMP) as _ingested_at,
    _source_file,
    _ingestion_run_id,
    _source_platform
FROM {{ source('raw_marketing_sources', 'facebook_new_acccount_de_randomized') }}
