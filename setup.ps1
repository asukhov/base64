# Download forge.js library for offline use
# This script downloads the node-forge library for the PFX Certificate Bundle Generator

Write-Host "PFX Certificate Bundle Generator - Dependency Setup" -ForegroundColor Green
Write-Host "=====================================================" -ForegroundColor Green
Write-Host ""

$forgeUrl = "https://cdn.jsdelivr.net/npm/node-forge@1.3.1/dist/forge.min.js"
$forgeFile = "forge.min.js"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Target directory: $scriptDir" -ForegroundColor Cyan
Write-Host ""

# Check if file already exists
if (Test-Path (Join-Path $scriptDir $forgeFile)) {
    Write-Host "Warning: $forgeFile already exists." -ForegroundColor Yellow
    $response = Read-Host "Do you want to overwrite it? (Y/N)"
    if ($response -ne "Y" -and $response -ne "y") {
        Write-Host "Operation cancelled." -ForegroundColor Yellow
        exit 0
    }
}

Write-Host "Downloading forge.js from CDN..." -ForegroundColor Cyan

try {
    # Download the file
    Invoke-WebRequest -Uri $forgeUrl -OutFile (Join-Path $scriptDir $forgeFile) -UseBasicParsing
    
    # Verify download
    $fileSize = (Get-Item (Join-Path $scriptDir $forgeFile)).Length
    
    if ($fileSize -gt 100KB) {
        Write-Host ""
        Write-Host "Success! forge.js downloaded successfully." -ForegroundColor Green
        Write-Host "File size: $([math]::Round($fileSize/1KB, 2)) KB" -ForegroundColor Green
        Write-Host ""
        Write-Host "The PFX Generator is now ready for offline use." -ForegroundColor Green
        Write-Host "You can open index.html in any modern web browser." -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "Error: Downloaded file seems too small. Please check your internet connection." -ForegroundColor Red
        Remove-Item (Join-Path $scriptDir $forgeFile) -ErrorAction SilentlyContinue
        exit 1
    }
    
} catch {
    Write-Host ""
    Write-Host "Error downloading forge.js: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Alternative methods:" -ForegroundColor Yellow
    Write-Host "1. Download manually from: https://cdn.jsdelivr.net/npm/node-forge@1.3.1/dist/forge.min.js" -ForegroundColor Yellow
    Write-Host "2. Save the file as 'forge.min.js' in this directory: $scriptDir" -ForegroundColor Yellow
    Write-Host "3. Or use npm: npm install node-forge" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "Setup complete! Press any key to exit..." -ForegroundColor Cyan
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
