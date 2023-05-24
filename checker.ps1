# counter to 0
$external_counter = 0
# Define the regular expression to match # labels
$regex = "^\s*#\w+"

# Set the directory containing the files to search
$directory = "D:\dosbox\tools\c\hangtime\src"

# Get all files in the directory that have a .txt extension
$files = Get-ChildItem $directory -Filter main.asm

# Loop through each file and find duplicate labels
foreach ($file in $files) {
    # Find all # labels in the file and group them by label
    $groups = Get-Content $file.FullName | Select-String -Pattern $regex -AllMatches | ForEach-Object { $_.Matches } | Group-Object Value

    # Find all groups with more than one match (i.e. duplicates)
    $duplicates = $groups | Where-Object { $_.Count -gt 1 }

    # Output the duplicate labels and the file they were found in
    foreach ($duplicate in $duplicates) {
        Write-Host "Duplicate label $($duplicate.Name) found in file $($file.FullName)"
        $external_counter ++
    }
}
# Print how many we have left
$external_counter