#!/bin/bash

# Define clusters and contexts
clusters=("c0" "c1" "c2" "c3")
contexts=("mCG" "mCH")

# Path to the directory containing the bedtools binary
BEDTOOLS_PATH="/share/lasallelab/Ensi/anaconda3/allcools/bin/bedtools"

# Path to chromatin state annotations
CHROMATIN_BED="chromatin_state_annotations.bed"

# Loop through each cluster and context
for cluster in "${clusters[@]}"; do
    for context in "${contexts[@]}"; do

        # Define file names
        LIFTED_BED="lifted_regions_${context}_${cluster}.bed"
        OUTPUT_FILE="chromatin_state_annotated_${context}_${cluster}.csv"

        # Check if the lifted BED file exists
        if [ ! -f $LIFTED_BED ]; then
            echo "File not found: $LIFTED_BED"
            continue
        fi

        # Run bedtools intersect
        $BEDTOOLS_PATH intersect -a $LIFTED_BED -b $CHROMATIN_BED -wa -wb > temp_intersected.bed

        # Convert the intersected output to a CSV format with appropriate headers
        echo "chromosome,start,end,state,value1,value2,value3,value4,value5,value6" > $OUTPUT_FILE
        awk 'BEGIN{FS="\t"; OFS=","} {print $1,$2,$3,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16}' temp_intersected.bed >> $OUTPUT_FILE

        # Remove the temporary intersected file
        rm temp_intersected.bed

        echo "Chromatin state annotated regions for $context $cluster saved successfully."
    done
done
