# Define the directory path and initialize an empty hashtable
$file_path = ".\ndsp1.asm"
$unique_lines = @{}
$duplicate_lines = @{}

    # Read the file and loop through each line
    Get-Content $file_path | ForEach-Object {
        # Check if the line starts with '#' followed by letters
        if ($_ -match "^#([a-zA-Z]+)") {
            $match = $matches[1]
            # Check if the line is already in the hashtable
            if ($unique_lines.ContainsKey($match)) {
                # Add the line to the duplicate_lines hashtable
                $duplicate_lines[$match] += 1
            } else {
                # Add the line to the unique_lines hashtable
                $unique_lines[$match] = $true
            }
        }
    }


# Count the number of unique and total lines
$num_unique = $unique_lines.Count
$num_total = (Get-ChildItem "$dir_path\*.asm" | ForEach-Object { Get-Content $_.FullName | Select-String "^#([a-zA-Z]+)" }).Count
$num_duplicates = $duplicate_lines.Count

# Output the results
Write-Host "Number of unique lines starting with # and followed by letters: $num_unique"
Write-Host "Number of total lines starting with # and followed by letters: $num_total"
Write-Host "Number of duplicate lines starting with # and followed by letters: $num_duplicates"
