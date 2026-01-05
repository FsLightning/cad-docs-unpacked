# Hardcoded generation script
$baseDir = "D:\MakeX\FsHoLu\cad-docs-unpacked\zwcad"
$tempBase = "D:\MakeX\FsHoLu\Tmp\GenDocs"
if (Test-Path $tempBase) { Remove-Item $tempBase -Recurse -Force }
New-Item $tempBase -ItemType Directory | Out-Null

function Process-Chm {
    param($relativePath)
    $fullPath = Join-Path $baseDir $relativePath
    $file = Get-Item $fullPath
    
    Write-Host "Processing $($file.Name)..."
    
    # Temp dir for this file
    $workDir = Join-Path $tempBase ([Guid]::NewGuid().ToString())
    New-Item $workDir -ItemType Directory | Out-Null
    
    # Decompile
    & hh.exe -decompile $workDir $file.FullName
    Start-Sleep -Seconds 2
    
    if ((Get-ChildItem $workDir).Count -eq 0) {
        Write-Error "Failed to decompile $($file.Name)"
        return
    }
    
    # Flatten HTML
    $htmls = Get-ChildItem $workDir -Filter *.htm* -Recurse -File
    foreach ($h in $htmls) {
        $dest = Join-Path $workDir $h.Name
        if ($h.FullName -ne $dest) {
            Move-Item $h.FullName $dest -Force
        }
    }
    
    # Clean non-html and dirs
    Get-ChildItem $workDir -Directory | Remove-Item -Recurse -Force
    Get-ChildItem $workDir -File | Where-Object { $_.Extension -ne ".html" -and $_.Extension -ne ".htm" } | Remove-Item -Force
    
    # Move to Final Dest (Sibling folder)
    $finalDest = Join-Path $file.DirectoryName $file.BaseName
    if (Test-Path $finalDest) { Remove-Item $finalDest -Recurse -Force }
    New-Item $finalDest -ItemType Directory | Out-Null
    
    Get-ChildItem $workDir | Move-Item -Destination $finalDest -Force
    Write-Host "Done: $finalDest"
}

# 2022
Process-Chm "Doc2022\DOTNET_Migration_Manual.chm"
Process-Chm "Doc2022\KnownDifferences.chm"
Process-Chm "Doc2022\ZDS.chm"
Process-Chm "Doc2022\ZRX_Mgd.chm"
Process-Chm "Doc2022\ZRX_Migration_Manual.chm"
Process-Chm "Doc2022\ZRX_Ref.chm"
Process-Chm "Doc2022\ZrxDev.chm"
Process-Chm "Doc2022\中望CAD_ZRX移植指南2021.chm"

# 2025
Process-Chm "Doc2025\DOTNET_Migration_Manual.chm"
Process-Chm "Doc2025\KnownDifferences.chm"
Process-Chm "Doc2025\ZDS.chm"
Process-Chm "Doc2025\ZRX_Mgd.chm"
Process-Chm "Doc2025\ZRX_Migration_Manual.chm"
Process-Chm "Doc2025\ZRX_Ref.chm"
Process-Chm "Doc2025\ZrxDev.chm"
Process-Chm "Doc2025\中望CAD_ZRX移植指南2026.chm"
