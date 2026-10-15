# Raw Layer Ingestion Contract

**Project:** CDE Marketing Data Platform  
**Source:** Google Drive  
**Destination:** Databricks Unity Catalog  
**Catalog:** `cde_marketing_production`  
**Schema:** `raw`  
**Storage Format:** Delta Lake

## 1. Objective

Ingest nine CSV files from Facebook and Snapchat into Databricks Delta tables while preserving source values and maintaining basic ingestion traceability.

## 2. Source Data

- Facebook: 5 CSV files
- Snapchat: 4 CSV files
- Total source size: approximately 21.68 MB

## 3. Data Type Policy

All source columns will initially be stored as strings.

Data type conversions and business standardization will be handled in downstream dbt models.

## 4. Table Naming Convention

Raw tables will use source-platform prefixes.

Examples:

- `facebook_ads_stats`
- `facebook_new_ads_de_randomized`
- `snapchat_ads_stats`

Existing `snapchat_` prefixes will not be duplicated.

## 5. Ingestion Metadata

Each raw table will contain four additional columns:

| Column | Purpose |
|---|---|
| `_ingested_at` | Timestamp of ingestion |
| `_source_file` | Original CSV filename |
| `_source_platform` | Facebook or Snapchat |
| `_ingestion_run_id` | Identifier for the pipeline execution |

## 6. Loading Strategy

**Full refresh (overwrite).**

- Initial execution loads the complete source file.
- Subsequent executions replace the corresponding raw table with the latest complete source file.
- Incremental loading and CDC are outside the scope of the initial implementation.

**Assumption:** Each source CSV represents a complete extract rather than only newly arrived records. This must be confirmed before relying on full refresh for ongoing updates.

## 7. Validation Requirements

Before overwriting a raw table:

- Confirm successful file retrieval and CSV parsing.
- Check that the file contains the expected columns.
- Reject unexpectedly empty or malformed files.
- Verify source and destination row counts after ingestion.
- Record ingestion failures for investigation.

## 8. Downstream Responsibilities

dbt will handle data type conversions, key and relationship testing, business transformations, and analytical models.

Elementary will support observability of dbt tests and data quality.

## 9. Scope

This contract applies to the initial nine CSV files used in the CDE Marketing Data Platform capstone.

Any changes to the loading strategy, source structure, or ingestion metadata should be documented here.