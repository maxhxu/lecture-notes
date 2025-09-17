#!/bin/bash

# A script to create a new day#.tex file in a specified course directory.
# The new file will have the next sequential number based on existing files.

show_help() {
    echo "Usage: $0 -c <course_code> [-n <name>]"
    echo "This script creates a new day#.tex file in the specified course directory."
    echo "The new file name is day(max_number + 1).tex."
    echo ""
    echo "  -c <course_code>  The course code (required)"
    echo "  -n <name>         Optional name for the section header (defaults to 'Lorum')"
    exit 1
}

# Default values
SECTION_NAME="Lorum"
COURSE_CODE=""

# Parse command line options
while getopts "c:n:" opt; do
    case "$opt" in
        c)
            COURSE_CODE=$OPTARG
            ;;
        n)
            SECTION_NAME=$OPTARG
            ;;
        *)
            show_help
            ;;
    esac
done

if [[ -z "$COURSE_CODE" ]]; then
    echo "Error: The '-c' flag is required."
    show_help
fi

if [ ! -d "$COURSE_CODE" ]; then
    echo "Error: Directory '$COURSE_CODE' does not exist."
    exit 1
fi

cd "$COURSE_CODE" || exit

# Find the current maximum number
max_num=0
for file in day*.tex; do
    if [[ -f "$file" ]]; then
        if [[ "$file" =~ day([0-9]+)\.tex ]]; then
            num="${BASH_REMATCH[1]}"
            if (( num > max_num )); then
                max_num=$num
            fi
        fi
    fi
done

new_num=$((max_num + 1))
new_filename="day${new_num}.tex"

DATE=$(date +"%b %d, %Y")
echo "\section{Day ${new_num}: ${SECTION_NAME} (${DATE})}" > "$new_filename"

touch "$new_filename"

echo "New file: $COURSE_CODE/$new_filename"
