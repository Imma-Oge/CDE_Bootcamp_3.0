#!/bin/bash
set -euo pipefail

# run this in the same directory as the etl_bash_script.sh script to move all JSON and CSV files to a folder named json_and_CSV.
cd "$(dirname "$0")"

source .env


echo "======= This script is used to move all JSON and CSV files to a folder named json_and_CSV.========="

# create a folder file dump if it does not exist

if [ ! -d "file_dump" ]; then
  mkdir "file_dump"
  
  echo "=== file_dump folder created ==="
else
  echo "=== file_dump folder already exists ==="
fi

echo "======= Starting Downloads ======="


FILES=($DATA_URL $JSON1_URL $JSON2_URL $PARQUET_URL $CSV1_URL $PDF_URL) 
FILE_NAMES=("finance.csv" "fishing_industry_by_country.json" "tropical_cyclone_records.json" "random_deals.parquet" "owid-energy-codebook.csv" "sample.pdf")

for i in "${!FILES[@]}"; do
  file="${FILES[$i]}"
  filename="${FILE_NAMES[$i]}"

  if curl -sL -o "file_dump/$filename" "$file"; then

    echo "======= SUCCESS: Downloaded $file to 'file_dump' folder ======="
  else
    echo "ERROR!!!: Failed to download $file"
    
  fi

done


echo "======= All download attempts completed inside 'file_dump' folder ======="

# move all JSON and CSV files only!! to a folder named json_and_CSV

if [ ! -d "json_and_CSV" ]; then
  mkdir "json_and_CSV"

  echo "=== json_and_CSV folder created ==="
else
  echo "=== json_and_CSV folder already exists ==="

fi

mv file_dump/*.json file_dump/*.csv json_and_CSV/

echo "======= All JSON and CSV files moved to 'json_and_CSV' folder ======="





