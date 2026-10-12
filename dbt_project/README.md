# Marketing Data Platform with Databricks & dbt

## Project Overview

This project focuses on designing and building a production-minded Marketing Data Platform that integrates advertising performance data from Facebook Ads and Snapchat Ads into a unified analytical data model.

The platform uses Databricks for data storage and processing, and dbt for data transformation, testing, and documentation.

The goal is to provide a consistent, reliable, and reusable source of marketing performance data that can support reporting, business analysis, and downstream analytical applications.

## Business Problem

Marketing teams often manage advertising campaigns across multiple platforms, each with its own data structures, naming conventions, and reporting interfaces.

In this case, advertising performance data is distributed between Facebook Ads and Snapchat Ads. Marketers must access these platforms separately or manually export and combine datasets to understand overall campaign performance.

This approach presents several challenges:

- **Fragmented reporting:** There is no unified view of advertising performance across platforms.
- **Manual effort:** Extracting, combining, and analyzing data requires additional time.
- **Inconsistent data structures:** Differences in field names and formats make cross-platform comparisons difficult.
- **Limited accessibility and reusability:** Other teams cannot easily consume the advertising data for their own analytical needs.
- **Limited governance and visibility:** The absence of centralized models, documentation, lineage, and automated data quality monitoring reduces trust and maintainability.

## Project Objectives

The primary objective is to develop a governed, tested, and documented marketing data platform that transforms raw advertising data into a unified analytical data product.

Specifically, the project aims to:

1. Ingest Facebook Ads and Snapchat Ads data into Databricks.
2. Standardize platform-specific advertising data through dbt transformations.
3. Develop a unified marketing model that supports consistent cross-platform analysis.
4. Enable analysis of advertising spend, impressions, clicks, and campaign performance over time.
5. Support marketing efficiency metrics, including cost per click (CPC) and cost per thousand impressions (CPM).
6. Implement data quality testing, documentation, lineage, and observability.
7. Establish separate development, CI, and production environments with appropriate authentication and access controls.
8. Make the resulting analytical data accessible and reusable through SQL, BI tools, and other downstream analytical applications.

## Expected Outcome

The intended outcome is a reliable, reusable marketing data model that allows analysts and other data consumers to evaluate advertising performance across Facebook and Snapchat without needing to understand the underlying differences between the source platforms.

The project also aims to demonstrate production-oriented data engineering practices, including environment isolation, automated validation, monitoring, and maintainable transformation workflows.

---

*Documentation status: Initial business overview and objectives. Architecture, implementation details, setup, and operational guidance will be added as the project progresses.*
