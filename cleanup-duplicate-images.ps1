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

function Get-References($DocsPath, $AssetPath, $AssetName) {
  [Array]$assetReferences = Get-ChildItem -Path $DocsPath -Recurse -Filter "*.md" | Select-String -SimpleMatch -Pattern $AssetName
  if ($AssetName.Contains(' ')) {
    [Array]$assetUrlReferences = Get-ChildItem -Path $DocsPath -Recurse -Filter "*.md" | Select-String -SimpleMatch -Pattern ($AssetName.Replace(' ','%20'))
    $assetReferences += $assetUrlReferences
  }
  if ($AssetName.Contains('_')) {
    [Array]$assetUnderScoreReferences = Get-ChildItem -Path $DocsPath -Recurse -Filter "*.md" | Select-String -SimpleMatch -Pattern ($AssetName.Replace('_','\_'))
    $assetReferences += $assetUnderScoreReferences
  }
  if ($AssetName.Contains('_') -and $AssetName.Contains(' ')) {
    [Array]$assetUnderScoreSpaceReferences = Get-ChildItem -Path $DocsPath -Recurse -Filter "*.md" | Select-String -SimpleMatch -Pattern ($AssetName.Replace('_','\_').Replace(' ','%20'))
    $assetReferences += $assetUnderScoreSpaceReferences
  }
  
  return $assetReferences | Where-Object { # There may be assets in another directory with the same name. Filter out references with the wrong path
    $assetRef = $_
    if ($null -eq $assetRef) {
      return $false # $nulls may come in when handling array in PS
    }
    $relativePath2Dir = [System.IO.Path]::GetRelativePath((Split-Path -Parent $assetRef.Path), (Resolve-Path $AssetPath))
    $relativePath2File = $relativePath2Dir.Replace('\','/') + $assetRef.Pattern # On Windows systems, we need to replace backward slashes, as there is only forward slashes in md
    return $assetRef.Line -match "(?<!\.\./)$([regex]::Escape($relativePath2File))" # match path, but there shall be no ../ before it
  }
}

# Based on https://stackoverflow.com/a/72390923
$FileGroups = Get-ChildItem -Path $AssetPath -File | Get-FileHash | Group-Object -Property Hash
$Duplicates = $FileGroups | Where-Object Count -gt 1
$Singles =  $FileGroups | Where-Object Count -eq 1

If ($duplicates.count -lt 1) {
  Write-Information "No duplicates found"
} else {
  Write-Information "Found $($duplicates.Count) groups of duplicates"

  foreach ($d in $duplicates) {
    $representativePath = $d.Group[0].Path
    Write-Verbose "Working on duplicate group with representative $representativePath ($($d.Group.Count) duplicates in group)"
    $targetFileName = $representativePath -replace '^(?<filename>[^(]+)( \([1-9][0-9]*\))+(?<fileextension>\.[a-z]+)$', '${filename}${fileextension}'
    $targetFileName = $targetFileName.Replace('_','-')  # Underscores need markdown escaping, which causes trouble down the line
    
    if (Test-Path $targetFileName) {
      # exists ... is it in the group?
      if (-not ($d.Group | Test-Any { $_.Path.EndsWith($targetFileName, [System.StringComparison]::InvariantCultureIgnoreCase) })) {
        $targetFileNameWithoutExtension = $targetFileName -replace '^(?<filename>.+)(?<fileextension>\.[a-z]+)$', '${filename}'
        $targetFileNameExtension = $targetFileName -replace '^(?<filename>.+)(?<fileextension>\.[a-z]+)$', '${fileextension}'
        $i = 1
        while(Test-Path "$targetFileNameWithoutExtension-$i$targetFileNameExtension") { 
          Write-Information "$targetFileNameWithoutExtension-$i$targetFileNameExtension exists already, searching for an unused file name"
          $null = ++$i
        }
        $targetFileName = "$targetFileNameWithoutExtension-$i$targetFileNameExtension" # does not exist yet
      }
    }

    Write-Verbose "TargetFileName for this group is $targetFileName"
    
    if (-not (Test-Path $targetFileName)) {
      $assetReferences = Get-References -DocsPath $DocsPath -AssetName (Split-Path $representativePath -Leaf) -AssetPath $AssetPath
      Rename-Item -Path $representativePath -NewName $targetFileName  # Rename one of the files to the target file name
      Write-Information "Created $targetFilename as representative for this group of files"
    }

    # Now we have $targetFileName as a file. We can delete all doppelgangers
    $deleteCounter = 0
    $referenceCounter = 0
    foreach ($duplicate in $d.Group) {
      $assetReferences = Get-References -DocsPath $DocsPath -AssetName (Split-Path $duplicate.Path -Leaf) -AssetPath $AssetPath
      Write-Verbose "Found $($assetReferences.Count) references for $($duplicate.Path)"
      $referenceCounter += $assetReferences.Count
      if ($duplicate.Path -ieq $targetFileName) { Continue } # skip the target File
      else {
        if ($assetReferences.Count -ge 1) {
          Write-Information "There are $($assetReferences.Count) occurances of $($assetReferences[0].Pattern) (to be replaced by $targetFileName)"
        }

        foreach ($assetReference in $assetReferences) {
          Write-Verbose "Replacing occurance of $($assetReference.Pattern) with $targetFileName in file $($assetReference.Path)"
          $lineWithNewReference = $assetReference.Line
          if (-not $targetFileName.Contains(' ')) { # the <> brackets are used in md only if the path contains spaces, but must not be used if there are no spaces (?)
            $lineWithNewReference = $lineWithNewReference.Replace('](<.','](.').Replace('>)',')')
          }
          $lineWithNewReference = $lineWithNewReference.Replace($assetReference.Pattern,(Split-Path $targetFileName -Leaf))
          (Get-Content $assetReference.Path).Replace($assetReference.Line,$lineWithNewReference) | Set-Content $assetReference.Path
        }

        if ($duplicate.Path -ieq $representativePath -and -not (Test-Path $representativePath)) { Continue } # we renamed this file, so skip deletion, it is already gone

        Remove-Item $duplicate.Path
        Write-Verbose "Deleted $($duplicate.Path)"
        $null = ++$deleteCounter
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
Write-Verbose "There are $($Singles.Count) single files"
foreach ($singleFileGroup in $Singles) {
  $filePath = $singleFileGroup.Group[0].Path
  $assetReferences = Get-References -DocsPath $DocsPath -AssetName (Split-path $filePath -leaf) -AssetPath $AssetPath

  if ($assetReferences.Count -eq 0) {
    Remove-Item $filePath
    Write-Information "Deleted unreferenced file $filePath"
  }
}