#!/bin/bash

# Specify the directory to check for file integrity
DIRECTORY="/path/to/directory"

# Specify the file to store checksums
CHECKSUM_FILE="checksums.txt"

# Function to calculate checksums and store them in a file
calculate_checksums() {
    cd "$DIRECTORY" || exit
    find . -type f -exec md5sum {} + > "$CHECKSUM_FILE"
}

# Function to compare checksums and detect changes
check_integrity() {
    cd "$DIRECTORY" || exit
    md5sum -c "$CHECKSUM_FILE" --quiet | grep -v ': OK$'
    if [[ $? -eq 0 ]]; then
        echo "File integrity check failed. Detected changes:"
    else
        echo "File integrity check passed. No changes detected."
    fi
}

# Main function
main() {
    echo "Calculating checksums..."
    calculate_checksums
    echo "Checksums calculated and stored in $CHECKSUM_FILE"
    echo "Checking file integrity..."
    check_integrity
}

# Run the main function
main
