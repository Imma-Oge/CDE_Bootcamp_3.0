#!/bin/bash
set -euo pipefail

# Force the sript to run in its own directory, regardless of where it is called from.
# This ensures "raw", "transformed", and "gold" are created right next to this script.
cd "$(dirname "$0")"

source ~/anaconda3/etc/profile.d/conda.sh
conda activate CDE

START_TIME=$(date "+%Y-%m-%d %H:%M:%S")

echo "======= ETL Pipeline started at $START_TIME ======="

echo "======= This script is used to perform ETL (Extract, Transform, Load) operations on a csv data file.============"
echo "======= ETL Pipeline loading.=========" 

# check if .env file exists in the same directory as this script, if not exit with an error message
if [ ! -f ".env" ]; then
  echo "ERROR: .env file not found in the same directory as this script. Please create the .env file."

  exit 1
fi
  source .env


# create a folder named raw, transformed, and gold if they do not exist

FOLDERS=("raw" "transformed" "gold")

for folder in "${FOLDERS[@]}"; do

  if [ ! -d "$folder" ]; then

    mkdir "$folder"
    echo "=== $folder folder created ==="

  else
    echo "=== $folder folder already exists ==="
  fi

done


# to download the data file from the specified URL and save it to raw folder

curl -o raw/annual-enterprise-survey-2023-financial-year-provisional.csv "$DATA_URL"

echo "======= Data file downloaded and saved to raw folder ======="

# perform a simple transformation by renaming Variable_code column to variable_code.

echo "======= Performing transformation on the data file and saving to 2023_year_finance.csv file ======="

python3 - <<"EOF"

import pandas as pd

# read the csv file from raw folder
df = pd.read_csv('raw/annual-enterprise-survey-2023-financial-year-provisional.csv')

# rename Variable_code column to variable_code
df = df.rename(columns={'Variable_code': 'variable_code'})

# select only the following columns: year, Value, Units, variable_code
df1=df[['Year', 'Value', 'Units', 'variable_code']]

# save the transformed data to a new csv file called 2023_year_finance.csv
df1.to_csv('transformed/2023_year_finance.csv', index=False)

EOF

echo "======= Data transformation completed and saved to transformed folder ======="

# move the transformed file to gold folder
cp transformed/2023_year_finance.csv gold/

echo "======= Transformed file moved to gold folder ========"


