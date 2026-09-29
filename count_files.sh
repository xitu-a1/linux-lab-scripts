#!/bin/bash

# script that counts files in a directory
# how to use: ./count_files.sh [-e extension] [-r] [-h] [directory]

PATTERN="*"             # by default count all files
DEPTH=(-maxdepth 1)     # by default look only in this directory

# read options from the command line
while getopts "e:rh" opt; do
    case $opt in
        e) PATTERN="*.${OPTARG#.}" ;; # -e conf or -e .conf: count only .conf files
        r) DEPTH=() ;;                # -r: remove the depth limit, look in all subdirectories
        h) echo "Usage: $0 [-e extension] [-r] [-h] [directory]"; exit 0 ;;
        *) echo "Usage: $0 [-e extension] [-r] [-h] [directory]"; exit 1 ;;
    esac
done
shift $((OPTIND - 1)) # skip the options, so $1 is now the directory

TARGET_DIR="${1:-/etc}" # directory from the command line, or /etc if none is given

# stop if the directory does not exist
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: directory $TARGET_DIR does not exist" >&2
    exit 1
fi

# stop if we can't read the directory
if [ ! -r "$TARGET_DIR" ] || [ ! -x "$TARGET_DIR" ]; then
    echo "Error: no permission to read directory $TARGET_DIR" >&2
    exit 1
fi

# count items of one type
count_items() {
    local dir=$1
    local type=$2
    local name=$3
    find -H "$dir" "${DEPTH[@]}" -type "$type" -name "$name" 2>/dev/null | wc -l
}

# count each type
files=$(count_items "$TARGET_DIR" "f" "$PATTERN")
dirs=$(count_items "$TARGET_DIR" "d" "*")
links=$(count_items "$TARGET_DIR" "l" "*")

# find prints file sizes like 0+120+35, then bash adds them up
sizes="0$(find -H "$TARGET_DIR" "${DEPTH[@]}" -type f -name "$PATTERN" -printf "+%s" 2>/dev/null)"
size=$((sizes))

# the results
echo "Statistics for directory $TARGET_DIR (files: $PATTERN):"
echo "  Regular files: $files"
echo "  Directories: $((dirs - 1))" # find also counts the directory itself
echo "  Symbolic links: $links"
echo "  -------------------------"
echo "  Total (files only): $files"
echo "  Total size: $size bytes"

exit 0
