
-- Aggregate advertising performance by platform, date, and currency and calculate marketing KPIs safely.

WITH aggregated_performance AS (
    SELECT
        platform,
        ad_date,
        currency_code,
        SUM(spend) AS total_spend,
        SUM(impressions) AS total_impressions,
        SUM(clicks) AS total_clicks
    FROM {{ ref('fct_marketing_performance') }}
    GROUP BY
        platform,
        ad_date,
        currency_code
)

SELECT
    platform,
    ad_date,
    currency_code,
    total_spend,
    total_impressions,
    total_clicks,
    ROUND(
        total_clicks * 100.0 / NULLIF(total_impressions, 0),
        2
    ) AS ctr_percentage,
    ROUND(
        total_spend / NULLIF(total_clicks, 0),
        4
    ) AS cpc,
    ROUND(
        total_spend * 1000.0 / NULLIF(total_impressions, 0),
        4
    ) AS cpm

FROM aggregated_performance
