#!/bin/bash

# A script to pull figures from my phone to my computer.

show_help() {
    echo "Usage: $0 -n <desired_file_name> [-d <directory_to_file>] [-c <course_code>]"
    echo "This script fetches the latest JPG or PNG in the specified directory on your phone,"
    echo "pulls it to your computer, and renames and moves it to the appropriate folder."
    echo ""
    echo "  -n <name>               The desired name of the file (required)."
    echo "  -d <directory>          The directory on your phone to pull from (optional)."
    echo "                          Defaults to /sdcard/Figures/."
    echo "  -c <course_code>        The course code to organize the figure (optional)."
    echo "                          Saves to ~/lecture-notes/<course_code>/figures/."
    echo "                          The directory ~/lecture-notes/<course_code> must already exist."
    exit 1
}

DIRECTORY="/sdcard/Figures/"
COURSE_CODE=""

while getopts "n:d:c:h" opt; do
    case ${opt} in
        n)
            NAME=$OPTARG
            ;;
        d)
            DIRECTORY=$OPTARG
            ;;
        c)
            COURSE_CODE=$OPTARG
            ;;
        h)
            show_help
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            show_help
            ;;
    esac
done

if [ -z "$NAME" ]; then
    echo "Error: The -n argument for the file name is required."
    show_help
fi

if [ -n "$COURSE_CODE" ]; then
    COURSE_PATH="$HOME/lecture-notes/$COURSE_CODE"
    if [ ! -d "$COURSE_PATH" ]; then
        echo "Error: The course directory $COURSE_PATH does not exist." >&2
        exit 1
    fi
    TARGET_DIR="$COURSE_PATH/figures"
else
    TARGET_DIR="$HOME/lecture-notes/"
fi

LATEST_FILE=$(adb shell "ls -t '$DIRECTORY' | grep -iE '\.jpe?g$|\.png$' | head -1 | tr -d '\r'")

if [ -z "$LATEST_FILE" ]; then
    echo "Error: No JPG or PNG files found in $DIRECTORY."
    exit 1
fi

EXTENSION="${LATEST_FILE##*.}"
FINAL_NAME="${NAME}.${EXTENSION}"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Creating directory: $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
fi

FINAL_PATH="$TARGET_DIR/$FINAL_NAME"

echo "Pulling $LATEST_FILE from $DIRECTORY..."
adb pull "$DIRECTORY/$LATEST_FILE" "$FINAL_PATH"

if [ $? -eq 0 ]; then
    echo "Rotating the image..."
    jpegtran -rotate 90 -outfile "$FINAL_PATH" "$FINAL_PATH"
else
    echo "Error: Failed to pull the file."
    exit 1
fi

echo "File pulled and rotated successfully as $FINAL_PATH."
