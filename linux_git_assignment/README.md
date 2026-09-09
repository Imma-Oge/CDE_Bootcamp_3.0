# Simple ETL & File Automation

This project has two small assignments, each in its own folder. One downloads and cleans up a data file (ETL). The other downloads several files and sorts them by type. Both were built and tested on Linux, inside the `linux_git_assignment` folder.

## Folder Structure

```
linux_git_assignment/
├── .env                          # holds all the download links - not shared publicly
├── .gitignore
├── INTRODUCTION.md
├── etl_assignment/
│   ├── etl_bash_script.sh         # downloads and cleans the data
│   ├── raw/                        # made when script runs - the original file
│   ├── transformed/                 # made when script runs - the cleaned file
│   ├── gold/                         # made when script runs - the final file
│   └── etl_cron.log                   # made by cron - a log of each scheduled run
└── json_csv_assignment/
    ├── move_json_csv_files.sh      # downloads files and sorts them
    ├── file_dump/                   # made when script runs - files before sorting
    └── json_and_CSV/                 # made when script runs - sorted files
```

## 1. `etl_assignment/etl_bash_script.sh` — Get and Clean the Data

This script downloads a CSV file, makes a small change to it, and saves the result in three stages: raw, transformed, and gold.

**What it does, step by step:**
1. Makes sure it always runs from its own folder, so the new folders it creates end up in the right place.
2. Turns on the `CDE` conda environment.
3. Checks for a `.env` file. This file must contain `DATA_URL`, the link to the data. If it's missing, the script stops and shows an error.
4. Creates three folders if they don't already exist: `raw`, `transformed`, and `gold`.
5. Downloads the data file and saves it in `raw`.
6. Runs a small Python step that:
   * renames the column `Variable_code` to `variable_code`
   * keeps only these columns: `Year`, `Value`, `Units`, `variable_code`
   * saves the result as `transformed/2023_year_finance.csv`
7. Copies that cleaned file into `gold`, which is the final, ready-to-use version.

**How it runs automatically:**
A cron job runs this script every day at exactly 12:00 noon. Each time it runs, the output is saved to a file called `etl_cron.log`, which sits in the same folder as the script and the `raw`, `transformed`, and `gold` folders.

Example cron line:
```
0 0 * * * /path/to/etl_assignment/etl_bash_script.sh >> /path/to/etl_assignment/etl_cron.log 2>&1
```

## 2. `json_csv_assignment/move_json_csv_files.sh` — Download and Sort Files

This script downloads six sample files, then sorts out the JSON and CSV ones into their own folder.

**What it does, step by step:**
1. Must be run from inside the `json_csv_assignment` folder.
2. Loads the download links from the `.env` file.
3. Creates a folder called `file_dump` if it doesn't already exist.
4. Downloads six files into `file_dump`, and prints whether each download succeeded or failed:
   * `finance.csv`
   * `fishing_industry_by_country.json`
   * `tropical_cyclone_records.json`
   * `random_deals.parquet`
   * `owid-energy-codebook.csv`
   * `sample.pdf`
5. Creates a folder called `json_and_CSV` if it doesn't already exist.
6. Moves only the `.json` and `.csv` files from `file_dump` into `json_and_CSV`. Other file types, like `.parquet` and `.pdf`, stay behind in `file_dump`.

## What You Need

* Bash
* `curl`
* Anaconda or Miniconda, with a `CDE` environment that has `pandas` installed (needed for `etl_bash_script.sh`)
* A `.env` file with all the needed links set: `DATA_URL`, `JSON1_URL`, `JSON2_URL`, `PARQUET_URL`, `CSV1_URL`, `PDF_URL`

## How to Run

```bash
# Run the ETL script by hand
./etl_assignment/etl_bash_script.sh

# Download and sort the sample files
./json_csv_assignment/move_json_csv_files.sh
```
