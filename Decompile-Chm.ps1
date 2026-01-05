param(
    [string]$Target = "."
)

$targetPath = Resolve-Path $Target
if (Test-Path $targetPath -PathType Container) {
    $files = Get-ChildItem -Path $targetPath -Filter *.chm -Recurse
}
elseif (Test-Path $targetPath -PathType Leaf) {
    if ($targetPath.Extension -eq ".chm") {
        $files = @(Get-Item $targetPath)
    }
    else {
        Write-Error "Target file is not a CHM file."
        exit 1
    }
}
else {
    Write-Error "Target path not found."
    exit 1
}

foreach ($file in $files) {
    # 1. Unblock the file (removes Mark of the Web)
    Unblock-File -Path $file.FullName

    # 2. Prepare output paths
    $outputDirName = $file.BaseName
    $finalFullPath = Join-Path $file.DirectoryName $outputDirName
    
    # Use a short temp path to avoid hh.exe 260 char limit issues
    # We use a local temp folder to ensure it works within the workspace/drive
    $localTempBase = "D:\MakeX\FsHoLu\Tmp"
    if (-not (Test-Path $localTempBase)) {
        New-Item -Path $localTempBase -ItemType Directory | Out-Null
    }
    $tempWorkDir = Join-Path $localTempBase ([Guid]::NewGuid().ToString())
    New-Item -Path $tempWorkDir -ItemType Directory | Out-Null
    
    Write-Host "Decompiling $($file.Name)..."

    # 3. Execute hh.exe
    # We use absolute paths for both source and destination to be safe.
    try {
        $process = Start-Process -FilePath "hh.exe" -ArgumentList "-decompile `"$tempWorkDir`" `"$($file.FullName)`"" -PassThru -Wait
        
        if ($process.ExitCode -eq 0) {
            # 3.1 Cleanup: Remove non-html files
            Get-ChildItem -Path $tempWorkDir -Recurse -File | Where-Object { $_.Extension -ne ".html" -and $_.Extension -ne ".htm" } | Remove-Item -Force

            # 3.2 Flatten: If 'html' folder exists, move content up
            $htmlSubDir = Join-Path $tempWorkDir "html"
            if (Test-Path $htmlSubDir) {
                Get-ChildItem -Path $htmlSubDir | Move-Item -Destination $tempWorkDir -Force
                Remove-Item -Path $htmlSubDir -Force -Recurse
            }

            # 3.3 Flatten generic: Move any remaining files in subfolders to root (if desired, but user specifically asked for html folder flattening)
            # Sticking to user request: "将 D:\...\html 这个文件夹中的内容移动到..."
            
            # 3.4 Cleanup: Remove Empty Directories
            # Do a bottom-up search to delete empty dirs
            Get-ChildItem -Path $tempWorkDir -Recurse -Directory | Sort-Object FullName -Descending | ForEach-Object {
                if ((Get-ChildItem -Path $_.FullName).Count -eq 0) {
                    Remove-Item -Path $_.FullName -Force
                }
            }

            # 4. Move content to final destination
            # First, clean destination if it exists to avoid stale files
            if (Test-Path $finalFullPath) {
                Remove-Item -Path $finalFullPath -Recurse -Force
            }
            New-Item -Path $finalFullPath -ItemType Directory | Out-Null
            
            # Move content
            Get-ChildItem -Path $tempWorkDir | Move-Item -Destination $finalFullPath -Force
            
            Write-Host "Success. Cleaned content moved to .\$outputDirName" -ForegroundColor Green
        }
        else {
            Write-Host "Failed with exit code $($process.ExitCode)." -ForegroundColor Red
        }
    }
    catch {
        Write-Host "Error during processing: $_" -ForegroundColor Red
    }
    finally {
        # Cleanup temp
        if (Test-Path $tempWorkDir) {
            Remove-Item -Path $tempWorkDir -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}
