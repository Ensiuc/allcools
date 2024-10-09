#!/bin/bash

# Define paths to your files
LIFTED_BED="lifted_regions_c1.bed"
CHROMATIN_BED="chromatin_state_annotations.bed"
OUTPUT_FILE="chromatin_state_annotated_regions_c1.csv"

# Ensure the bedtools is executable
chmod +x /share/lasallelab/Ensi/anaconda3/allcools/bin/bedtools

# Run bedtools intersect
/share/lasallelab/Ensi/anaconda3/allcools/bin/bedtools intersect -a $LIFTED_BED -b $CHROMATIN_BED -wa -wb > temp_intersected.bed

# Optionally, add headers and convert to CSV
echo "chrom,start,end,chromatin_state" > $OUTPUT_FILE
awk 'BEGIN{FS="\t"; OFS=","} {print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14}' temp_intersected.bed >> $OUTPUT_FILE

# Clean up if necessary
rm temp_intersected.bed

echo "Chromatin state annotated regions saved successfully."

