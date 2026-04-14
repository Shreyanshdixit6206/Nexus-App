Set-Location "x:\Personel Projects\Major project\Health-Nexus"
Write-Host "Starting repository cleanup..."

$toDelete = @("api","server","frontend","Data sets","AGENTS.md","DEPLOY_NOW.md","FEATURES.md","health_nexus_patent_prototype_architecture_guide.md","index.html","indian_pharmaceutical_products_clean.csv","start-server.ps1","VERCEL_DEPLOYMENT.md","VERCEL_FIX.md","RUNNING_GUIDE.md","pradhan-mantri-jan-aushadhi-logo-01.svg","SKILL.md","SKILL (1).md","SKILL (2).md","SKILL (3).md","SKILL (4).md","SKILL (5).md","SKILL (6).md","SKILL (7).md","SKILL (8).md","package.json","README.md")

foreach ($item in $toDelete) {
    if (Test-Path $item) {
        Remove-Item $item -Recurse -Force
        Write-Host "[OK] Deleted: $item"
    }
}

Write-Host "Copying files from nexus-webapp..."
$filesToCopy = @("package.json","package-lock.json","tsconfig.json","next.config.ts","next-env.d.ts","jest.config.js","jest.setup.js","postcss.config.mjs","eslint.config.mjs",".env.local",".env.example",".gitignore","README.md","DEPLOYMENT.md")

foreach ($file in $filesToCopy) {
    $source = "nexus-webapp\$file"
    if (Test-Path $source) {
        Copy-Item $source . -Force
        Write-Host "[OK] Copied: $file"
    }
}

Write-Host "Copying directories..."
$dirsToCopy = @("src","public","scripts","__tests__")

foreach ($dir in $dirsToCopy) {
    $source = "nexus-webapp\$dir"
    if (Test-Path $source) {
        if (Test-Path $dir) { Remove-Item $dir -Recurse -Force }
        Copy-Item $source . -Recurse
        Write-Host "[OK] Copied: $dir"
    }
}

Write-Host "Updating vercel.json..."
if (Test-Path "vercel.json.new") {
    Remove-Item "vercel.json" -Force
    Rename-Item "vercel.json.new" "vercel.json"
}

Write-Host "Finalizing..."
if (Test-Path "nexus-webapp\.next") {
    if (Test-Path ".next") { Remove-Item ".next" -Recurse -Force }
    Copy-Item "nexus-webapp\.next" . -Recurse
}

if (Test-Path "nexus-webapp") { Remove-Item "nexus-webapp" -Recurse -Force }

Write-Host "Staging and committing..."
& git add -A
& git commit -m "Clean repository - Move Next.js app to root level for Vercel deployment"
& git push origin main --force

Write-Host "COMPLETE"
