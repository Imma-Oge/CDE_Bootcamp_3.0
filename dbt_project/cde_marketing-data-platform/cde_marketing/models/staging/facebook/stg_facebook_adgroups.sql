



SELECT
    ad_group_id as facebook_adgroup_id,
    ad_group_name as facebook_adgroup_name,
    TRY_CAST(NULLIF(LOWER(TRIM(ad_group_updated_at)), 'null') AS DATE) AS facebook_adgroup_updated_at,
    TRY_CAST(NULLIF(LOWER(TRIM(_ingested_at)), 'null') AS TIMESTAMP) AS _ingested_at,

    _source_file,
    _source_platform,
    _ingestion_run_id
FROM {{ source('raw_marketing_sources', 'facebook_new_adgroup_de_randomized') }}