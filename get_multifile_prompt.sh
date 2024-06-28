#!/bin/bash

# Initialize the variables
copy_cmd=()
search_in_subdirs=0
file_patterns=()
s=""

# Colors
C_RED='\033[0;31m'
C_GREEN='\033[1;32m'
C_YELLOW='\033[0;33m'   
C_NOCOLOR='\033[0m'

# Check for the clipboard utility before proceeding.
if command -v xclip &> /dev/null; then
    copy_cmd+=(xclip -selection clipboard)
elif command -v pbcopy &> /dev/null; then
    copy_cmd+=(pbcopy)
else
    echo -e "${C_RED}No clipboard utility found. Please install xclip or pbcopy.${C_NOCOLOR}"
    exit 1
fi

# Process the arguments list.
while test $# -gt 0
do
    case "$1" in
        -r|--recursive) 
            search_in_subdirs=1;;
        *) 
            if [[ "${#file_patterns[@]}" -eq 0 ]]; then
                file_patterns+=(-name "$1")
            else
                file_patterns+=(-o -name "$1")
            fi
    esac
    shift
done

# If no file patterns are provided, search for all files
if [[ "${#file_patterns[@]}" -eq 0 ]]; then
    file_patterns=(-name "*")
fi

# Function to search files based on the given pattern
search_files() {
    local patterns=("$@")
    if [[ "$search_in_subdirs" == 1 ]]; then
        # Find files in the current directory and its subdirectories that match the specified patterns
        find . -type f \( "${patterns[@]}" \) 2>/dev/null
    else
        # Look for files in the current directory that match the specified patterns
        find . -maxdepth 1 -type f \( "${patterns[@]}" \) 2>/dev/null
    fi
}

# Search for file patterns
found_files=$(search_files "${file_patterns[@]}")

if [[ -z "$found_files" ]]; then
    echo -e "${C_YELLOW}No files found."
    exit 0
else
    for file in $found_files; do
        # Read the file contents
        file_contents=$(cat "$file")
        echo -e "${C_YELLOW}File found:${C_NOCOLOR} $file"

        # Append the formatted string to s
        s+="\`\`\`${file}\n${file_contents}\`\`\`\n"
    done
fi

# Copy the string s to the clipboard
echo -e "$s" | "${copy_cmd[@]}"
echo -e "\n${C_GREEN}The prompt has been copied to the clipboard!${C_NOCOLOR}"
