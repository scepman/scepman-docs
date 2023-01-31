<#
Cleanup Duplicate Images

Searches a given directory for files that start with the same name, but have prefixes like (1) (1) (2) or (2) (1) (1) (3). For each set of files with equal name and content, all files will be deleted but a single file without suffix.
#>
param
( 
[Parameter(Position=0,Mandatory=$true,ValueFromPipeline=$false,HelpMessage='path to the directory with asset files, possibly containing duplicates')][string]$AssetPath,
[Parameter(Position=0,Mandatory=$true,ValueFromPipeline=$false,HelpMessage='path to the directory with docs files containing references to assets')][string]$DocsPath
)

# https://stackoverflow.com/a/22090065
function Test-Any {
  [CmdletBinding()]
  param($EvaluateCondition,
      [Parameter(ValueFromPipeline = $true)] $ObjectToTest)
  begin {
      $any = $false
  }
  process {
      if (-not $any -and (& $EvaluateCondition $ObjectToTest)) {
          $any = $true
      }
  }
  end {
      $any
  }
}

# Based on https://stackoverflow.com/a/72390923
$FileGroups = Get-ChildItem -Path $AssetPath -File | Get-FileHash | Group-Object -Property Hash
$Duplicates = $FileGroups | Where-Object Count -gt 1
$Singles =  $FileGroups | Where-Object Count -eq 1

If ($duplicates.count -lt 1) {
  Write-Information "No duplicates found"
} else {
  foreach ($d in $duplicates) {
    $representativePath = $d.Group[0].Path
    Write-Verbose "Working on duplicate group with representative $representativePath"
    $targetFileName = $representativePath -replace '^(?<filename>[^(]+)( \([1-9][0-9]*\))+(?<fileextension>\.[a-z]+)$', '${filename}${fileextension}'
    
    if (Test-Path $targetFileName) {
      # exists ... is it in the group?
      if (-not ($d.Group | Test-Any { $_.Path.EndsWith($targetFileName, [System.StringComparison]::InvariantCultureIgnoreCase) })) {
        $targetFileNameWithoutExtension = $targetFileName -replace '^(?<filename>.+)(?<fileextension>\.[a-z]+)$', '${filename}'
        $targetFileNameExtension = $targetFileName -replace '^(?<filename>.+)(?<fileextension>\.[a-z]+)$', '${fileextension}'
        $i = 1
        while(Test-Path "$targetFileNameWithoutExtension-$i$targetFileNameExtension") { 
          Write-Information "$targetFileNameWithoutExtension-$i$targetFileNameExtension exists already, searching for an unused file name"
          ++$i
        }
        $targetFileName = "$targetFileNameWithoutExtension-$i$targetFileNameExtension" # does not exist yet
      }
    }
    
    if (-not (Test-Path $targetFileName)) {
      Rename-Item -Path $representativePath -NewName $targetFileName  # Rename one of the files to the target file name
      Write-Information "Created $targetFilename as representative for this group of files"
    }

    # Now we have $targetFileName as a file. We can delete all doppelgangers
    $deleteCounter = 0
    $referenceCounter = 0
    foreach ($duplicate in $d.Group) {
      $assetReferences = Get-ChildItem -Path $DocsPath -Recurse -Filter "*.md" | Select-String -SimpleMatch -Pattern (Split-path $duplicate.Path -leaf)
      $referenceCounter += $assetReferences.Count
      foreach ($assetReference in $assetReferences) {
        Write-Information "Asset $($duplicate.Path) usage: $assetReference"
      }
      if ($duplicate.Path -ieq $targetFileName) { Continue } # skip the target File
      elseif ($duplicate.Path -ieq $representativePath -and -not (Test-Path $representativePath)) { Continue } # we renamed this file, so skip
      else {
        Remove-Item $duplicate.Path
        Write-Verbose "Deleted $($duplicate.Path)"
        ++$deleteCounter
      }
    }

    if ($referenceCounter -eq 0) {
      Remove-Item $targetFileName
      Write-Information "$targetFileName wasn't used at all, therefore it was deleted."
    }

    Write-Information "Deleted $deleteCounter doppelgangers of $targetFileName; Total $referenceCounter references"
  }
}

Write-Information "Inspecting usage of single files"
foreach ($singleFileGroup in $Singles) {
  $filePath = $singleFileGroup.Group[0].Path
  $assetReferences = Get-ChildItem -Path $DocsPath -Recurse -Filter "*.md" | Select-String -SimpleMatch -Pattern (Split-path $filePath -leaf)
  if ($assetReferences.Count -eq 0) {
    Remove-Item $filePath
    Write-Information "Deleted unreferenced file $filePath"
  }
}