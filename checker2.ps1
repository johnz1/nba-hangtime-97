$sourceFile = "D:\dosbox\tools\c\hangtime\src\PLYRRSEQ.asm"

$content = Get-Content $sourceFile

# Process each line to identify sections and labels
$sectionCount = 0
$sections = @()

for ($i = 0; $i -lt $content.Count; $i++) {
    $line = $content[$i].Trim()

    # Check if line is a section header
    if ($line -match '^#\*') {
        $sectionCount++
        $section = [ordered]@{
            "SectionHeader" = $line
            "Lines" = @()
            "Labels" = @()
        }

        # Store lines until next section header or end of file
        $j = $i + 1
        while ($j -lt $content.Count -and $content[$j].Trim() -notmatch '^#\*') {
            $section["Lines"] += $content[$j].Trim()
            $j++
        }

        # Find labels in the section
        #$section["Labels"] = $section["Lines"] -match '(?mi)^#([A-Za-z0-9_]+)\b\s' #-replace '^#'
	$section["Labels"] = $section["Lines"] -split '\s+' | Where-Object { $_ -match '^#([A-Za-z0-9_]+)\b' }

        # Exclude section header label
        $section["Labels"] = $section["Labels"] | Where-Object { $_ -ne $line -replace '#\*' }

        $sections += $section
        $i = $j - 1
    }
}

# Print the number of sections
Write-Host "Number of sections found: $sectionCount"
Write-Host

# Process each section
foreach ($section in $sections) {
    $sectionHeader = $section["SectionHeader"]
    $lines = $section["Lines"]
    $labels = $section["Labels"]

    # Print section information
    Write-Host "Section Header: $sectionHeader"
    Write-Host "Number of Lines: $($lines.Count)"
#    Write-Host "Lines:"
#    $lines | ForEach-Object { Write-Host $_ }
    Write-Host
    Write-Host "Labels found: $($labels.Count)"
    Write-Host "Labels: $($labels -join ', ')"
    Write-Host
}
