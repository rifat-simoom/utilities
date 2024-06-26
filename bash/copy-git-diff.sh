# Variables
source_branch="origin/dev"
target_branch="origin/rifat"
source_directory="/var/www/html/softrobotics/"
destination_directory="/home/rifat-simoom/Desktop/git-diff"

# Create the destination directory if it doesn't exist
mkdir -p "$destination_directory"

# Get the list of changed files with their statuses
cd "$source_directory"
git diff --name-status "$source_branch" "$target_branch" > changed_files.txt

# Read each line from the changed_files.txt
while IFS=$'\t' read -r status filepath; do
    # Check the status to ensure only added or modified files are copied
    if [ "$status" = "A" ] || [ "$status" = "M" ]; then
        # Create the necessary directory structure in the destination directory
        mkdir -p "$destination_directory/$(dirname "$filepath")"
        # Copy the file to the destination directory
        cp "$filepath" "$destination_directory/$filepath"
    fi
done < changed_files.txt

# Clean up
rm changed_files.txt

echo "Files have been copied to $destination_directory"
