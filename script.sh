#!/bin/bash

# Script to retrieve SMART data from all drives on a Synology and output it to a text file.

# Change this name to something like "smart_data_$(date +%Y%m%d_%H%M%S).txt" if you want to track historical data
OUTPUT_FILE="smart_data.txt"
truncate -s 0 "$OUTPUT_FILE"

# Function to get SMART data for a single drive.
get_smart_data() {
  local drive="$1"
  echo "----------------------------------------" >> "$OUTPUT_FILE"
  echo "SMART Data for drive: $drive" >> "$OUTPUT_FILE"
  echo "----------------------------------------" >> "$OUTPUT_FILE"
  smartctl -a -d sat "$drive" 2>&1 >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
}

# Find all SATA drives
drives=$(ls /dev/sata[0-9] 2>/dev/null)

if [ -z "$drives" ]; then
  echo "No drives found."
  exit 1
fi

echo "Retrieving SMART data for all drives..."
for drive in $drives; do
  get_smart_data "$drive"
done


exit 0
