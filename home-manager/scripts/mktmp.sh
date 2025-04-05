#!/bin/sh

func_new() {
    # Create a temporary directory
    tmp_dir=$(mktemp -d)

    # Ask for folder name
    if [ -z "$1" ]; then
        echo "Warning: No folder name provided. No symbolic link will be created."
        cd "$tmp_dir"

    else
        # Check if the folder name already exists
        if [ -e "$HOME/.cache/mktmp/$1" ]; then
            echo "Error: '$1' already exists. Please choose a different name."
        else

            # Create the symbolic link with the specified folder name
            ln -s "$tmp_dir" "$HOME/.cache/mktmp/$1"

            echo "'$tmp_dir' -> '$1'" >>"$HOME/.cache/mktmp/config"
            echo "Symbolic link '$HOME/.cache/mktmp/$1' -> '$tmp_dir' created."

            cd "$HOME/.cache/mktmp/$1"
        fi
    fi

}

func_clean_up() {
    # Clean up the temporary directory

    input_file="$HOME/.cache/mktmp/config"
    temp_backup_file=$(mktemp)

    while IFS= read -r line; do
        # Check if the line contains a symlink (has '->')
        if [[ "$line" == *"->"* ]]; then
            # Extract left and right parts
            right=$(echo "$line" | awk -F"->" '{print $1}' | xargs)
            left=$(echo "$line" | awk -F"->" '{print $2}' | xargs | tr -d "'")

            if [[ ! -e "$right" ]]; then
                echo "Target '$right' does not exist. Deleting '$left'"
                rm "$HOME/.cache/mktmp/$left"
            else
                echo "$line" >>"$temp_backup_file"
            fi
        fi
    done <"$input_file"
    # Replace the original file with the backup
    mv "$temp_backup_file" "$input_file"
}

func_follow() {
    # Follow the symbolic link
    input_file="$HOME/.cache/mktmp/config"

    while IFS= read -r line; do
        # Check if the line contains a symlink (has '->')
        if [[ "$line" == *"->"* ]]; then
            # Extract left and right parts
            right=$(echo "$line" | awk -F"->" '{print $1}' | xargs)
            left=$(echo "$line" | awk -F"->" '{print $2}' | xargs | tr -d "'")

            if [[ "$2" = "$left" ]]; then
                cd "$right"
            fi

        fi
    done <"$input_file"
}

func_delete() {
    # Delete the symbolic link
    input_file="$HOME/.cache/mktmp/config"
    temp_backup_file=$(mktemp)

    while IFS= read -r line; do
        # Check if the line contains a symlink (has '->')
        if [[ "$line" == *"->"* ]]; then
            # Extract left and right parts
            right=$(echo "$line" | awk -F"->" '{print $1}' | xargs)
            left=$(echo "$line" | awk -F"->" '{print $2}' | xargs | tr -d "'")

            if [[ "$2" = "$left" ]]; then
                rm "$HOME/.cache/mktmp/$left"
            else
                echo "$line" >>"$temp_backup_file"
            fi
        fi
    done <"$input_file"
    # Replace the original file with the backup
    mv "$temp_backup_file" "$input_file"
}

if [ ! -f "$HOME/.cache/mktmp/config" ]; then
    mkdir -p "$HOME/.cache/mktmp"
    touch "$HOME/.cache/mktmp/config"

fi

# Check if the arg 1 if '-d' and if so, delete all the files in the tmp dir
# if arg 2 is passed delete only the file
if [ "$1" = "-d" ] && [ -n "$2" ]; then
    func_delete $@

elif [ "$1" = "-d" ]; then
    read -p "Are you sure you want to delete all files in the mktmp directory? (y/n) " confirm
    if [ "$confirm" = "y" ]; then
        rm -rf "$HOME/.cache/mktmp"
        mkdir -p "$HOME/.cache/mktmp"
        touch "$HOME/.cache/mktmp/config"

    fi
elif [ "$1" = "-f" ]; then
    func_follow $@

elif [ "$1" = "-c" ]; then
    echo "Cleaning up the config file..."
elif [ "$1" = "-h" ]; then
    echo "Usage: mktmp [-(d|f|c|h)] [folder_name]"
    echo "  no args: Create a new temporary directory"
    echo "  folder_name: Name of the folder to create a temporary directory and symbolic link to it"
    echo "  -d folder_name: Delete the symbolic link to the temporary directory"
    echo "  -d: Delete all files in the mktmp directory"
    echo "  -f: Follow the symbolic link to the temporary directory"
    echo "  -c: Only clean up the config file"
    echo "  -h: Show this help message"

else
    func_new $@

fi

# Cleaning up the config file
func_clean_up
