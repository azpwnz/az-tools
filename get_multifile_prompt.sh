#!/bin/bash

# Check if the first argument is the option to search in subdirectories
search_in_subdirs=$1
shift # Remove the first argument from the list

# Array of file names (patterns)
file_patterns=("$@")

# Initialize the string s
s=""

# Function to search files based on the given pattern
search_files() {
    local pattern=$1
    if [[ "$search_in_subdirs" == "-r" ]]; then
        # Find files in the current directory and subdirectories matching the pattern
        find . -type f -name "$pattern" 2>/dev/null
    else
        # Look for files in the current directory only matching the pattern
        find . -maxdepth 1 -type f -name "$pattern" 2>/dev/null
    fi
}

# Loop through each file pattern
for pattern in "${file_patterns[@]}"; do
    found_files=$(search_files "$pattern")
    if [[ -z "$found_files" ]]; then
        echo "No files found for pattern: $pattern"
    else
        for file in $found_files; do
            # Read the file contents
            file_contents=$(cat "$file")
            echo "File found: $file"
            # Append the formatted string to s
            s+="\`\`\`${file}\n${file_contents}\`\`\`\n"
        done
    fi
done

# Copy the string s to the clipboard
if command -v xclip &> /dev/null; then
    echo -e "$s" | xclip -selection clipboard
elif command -v pbcopy &> /dev/null; then
    echo -e "$s" | pbcopy
else
    echo "No clipboard utility found. Please install xclip or pbcopy."
fi
