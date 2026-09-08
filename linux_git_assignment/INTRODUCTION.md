# Simple ETL & File Automation

This project has two Bash scripts. One downloads and cleans up a data file (ETL). The other downloads sample files and sorts them into folders. Both were built and tested on Linux, inside the `linux_git_assignment` folder.

## Folder Structure

```
linux_git_assignment/
├── .env                     # holds the DATA_URL link - not shared publicly
├── .gitignore
├── INTRODUCTION.md
├── etl_bash_script.sh        # downloads and cleans the data
├── move_json_csv_files.sh    # downloads files and sorts them
├── raw/                       # made when script runs - the original file
├── transformed/                # made when script runs - the cleaned file
├── gold/                       # made when script runs - the final file
├── file_dump/                  # made when script runs - files before sorting
├── json_and_CSV/                # made when script runs - sorted files
└── etl_cron.log                 # made by cron - a log of each scheduled run
```

## 1. `etl_bash_script.sh` — Get and Clean the Data

This script downloads a CSV file, makes a small change to it, and saves the result in three stages: raw, transformed, and gold.

**What it does, step by step:**
1. Makes sure it always runs from its own folder, so the new folders it creates end up in the right place.

2. Turns on the `CDE` conda environment.

3. Checks for a `.env` file in the same folder. This file must contain `DATA_URL`, the link to the data. If it's missing, the script stops and shows an error.

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
0 0 * * * /path/to/etl_bash_script.sh >> /path/to/etl_cron.log 2>&1
```

## 2. `move_json_csv_files.sh` — Download and Sort Files

This script downloads a few sample files, then sorts out the JSON and CSV ones into their own folder.

**What it does, step by step:**

1. Must be run from the same folder as `etl_bash_script.sh`.

2. Creates a folder called `file_dump` if it doesn't already exist.

3. Downloads five sample files into `file_dump`, and prints whether each download succeeded or failed:
   * `user_comment.json`
   * `country_capitals.json`
   * `owid_energy_data.csv`
   * `vix_daily.csv`
   * `sample.parquet`

4. Creates a folder called `json_and_CSV` if it doesn't already exist.

5. Moves only the `.json` and `.csv` files from `file_dump` into `json_and_CSV`. Other file types, like `.parquet`, stay behind in `file_dump`.

## What You Need

* Bash
* `curl`
* Anaconda or Miniconda, with a `CDE` environment that has `pandas` installed (needed for `etl_bash_script.sh`)
* A `.env` file with `DATA_URL` set, placed next to `etl_bash_script.sh`

## How to Run

```bash
# Run the ETL script by hand
./etl_bash_script.sh

# Download and sort the sample files
./move_json_csv_files.sh
```