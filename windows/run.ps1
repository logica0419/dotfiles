if (-not $env:USERPROFILE) {
  throw "USERPROFILE is not set."
}

Write-Host "Deploying WSL host configuration`n"

$wslConfigUrl = "https://raw.githubusercontent.com/logica0419/dotfiles/main/windows/files/wslconfig"
$wslConfigDestination = Join-Path $env:USERPROFILE ".wslconfig"
Invoke-WebRequest -Uri $wslConfigUrl -OutFile $wslConfigDestination

Write-Host "Deploying Git configuration`n"

$gitConfigUrl = "https://raw.githubusercontent.com/logica0419/dotfiles/main/windows/files/gitconfig"
$gitConfigDestination = Join-Path $env:USERPROFILE ".gitconfig"
Invoke-WebRequest -Uri $gitConfigUrl -OutFile $gitConfigDestination

Write-Host "Installing machine-scoped packages`n"

$machine_packages = @(
  "Bitwarden.Bitwarden"
  "CrystalDewWorld.CrystalDiskInfo"
  "CrystalDewWorld.CrystalDiskMark"
  "KiCad.KiCad"
  "Microsoft.Office"
  "Rufus.Rufus"
  "XnSoft.XnConvert"
  "Microsoft.PowerShell"
  "Apple.iTunes"
  "Mattermost.MattermostDesktop"
  "Logitech.GHUB"
  "Zoom.Zoom"
  "Google.Chrome"
  "Musescore.Musescore"
  "Romanitho.Winget-AutoUpdate"
  "WavesAudio.WavesCentral"
  "Adobe.CreativeCloud"
  "OBSProject.OBSStudio"
  "iZotope.ProductPortal"
  "Valve.Steam"
  "Yamaha.SteinbergUSBDriver"
  "Tailscale.Tailscale"
  "Figma.Figma"
  "Git.Git"
  "GitHub.cli"
  "OpenJS.NodeJS.LTS"
  "Mozilla.Thunderbird.ja"
  "Microsoft.PowerToys"
)

foreach ($package in $machine_packages) {
  Write-Host "Installing $package"
  winget install $package --scope machine --accept-package-agreements --accept-source-agreements
}

winget upgrade --all --scope machine --accept-package-agreements --accept-source-agreements

Write-Host "`nInstalling user-scoped packages`n"

$user_packages = @(
  "OpenWhisperSystems.Signal"
  "DevToys-app.DevToys"
  "Discord.Discord"
  "XPFCC4CD725961" # LINE
  "SlackTechnologies.Slack"
  "Microsoft.VisualStudioCode"
  "File-New-Project.EarTrumpet"
  "Canonical.Ubuntu"
  "Microsoft.AppInstaller"
  "Microsoft.WindowsTerminal"
  "9P1XD8ZQJ7JD" # Fre:ac
)

foreach ($package in $user_packages) {
  Write-Host "Installing $package"
  winget install $package --scope user --accept-package-agreements --accept-source-agreements
}

winget upgrade --all --scope user --accept-package-agreements --accept-source-agreements

Write-Host "`nAuthenticating GitHub CLI`n"

$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User") + ";" + $env:Path

if (Get-Command gh -ErrorAction SilentlyContinue) {
  gh auth status 2>$null
  if ($LASTEXITCODE -ne 0) {
    gh auth login
  }
} else {
  Write-Warning "gh not found on Path; skipping gh auth login."
}

Write-Host "`nCloning dotfiles`n"

$dotfilesDir = Join-Path $env:USERPROFILE "dotfiles"
if (-not (Test-Path $dotfilesDir)) {
  git clone https://github.com/logica0419/dotfiles.git $dotfilesDir
} else {
  git -C $dotfilesDir pull --ff-only
}

Write-Host "`nSetting up After Effects MCP`n"

$adobeDir = Join-Path ([Environment]::GetFolderPath("MyDocuments")) "Adobe"
$aeMcpDir = Join-Path $adobeDir "after-effects-mcp"

if (-not (Test-Path $adobeDir)) {
  New-Item -ItemType Directory -Path $adobeDir | Out-Null
}

if (-not (Test-Path $aeMcpDir)) {
  git clone https://github.com/ishu86/after-effects-mcp.git $aeMcpDir
} else {
  git -C $aeMcpDir pull --ff-only
}

Push-Location $aeMcpDir
npm install
npm run build
Pop-Location

$aeInstallDir = Get-ChildItem (Join-Path $env:ProgramFiles "Adobe") -Directory -Filter "Adobe After Effects*" -ErrorAction SilentlyContinue | Select-Object -First 1
if ($aeInstallDir) {
  Write-Output "" | cmd /c "`"$aeMcpDir\scripts\install-cep.bat`""
}

$aeMcpVscodeDir = Join-Path $aeMcpDir ".vscode"
if (-not (Test-Path $aeMcpVscodeDir)) {
  New-Item -ItemType Directory -Path $aeMcpVscodeDir | Out-Null
}
$aeMcpJsonPath = Join-Path $aeMcpVscodeDir "mcp.json"
$aeMcpJson = @'
{
  "servers": {
    "after-effects": {
      "command": "node",
      "args": [
        "${workspaceFolder}/dist/index.js"
      ]
    }
  }
}
'@
Set-Content -Path $aeMcpJsonPath -Value $aeMcpJson -Encoding utf8

Write-Host "`nCreating BlockList for Winget-AutoUpdate`n"

$blockListUrl = "https://raw.githubusercontent.com/logica0419/dotfiles/main/windows/files/excluded_apps.txt"
$blockListDestination = Join-Path $env:ProgramFiles "Winget-AutoUpdate\excluded_apps.txt"
Invoke-WebRequest -Uri $blockListUrl -OutFile $blockListDestination

Write-Host "Setting up an auto-upgrade script`n"

$startupBatPath = Join-Path $env:APPDATA "Microsoft\Windows\Start Menu\Programs\Startup\winget_upgrade.bat"
$startupBatLines = @(
  "@echo off"
  "for %%P in ("
) + ($user_packages | ForEach-Object { "`t$_" }) + @(
  ") do ("
  "`techo Upgrading %%P..."
  "`twinget upgrade --id %%P --scope user --accept-package-agreements --accept-source-agreements"
  ")"

  "winget upgrade --all --scope user --accept-package-agreements --accept-source-agreements"

  "echo Updating dotfiles..."
  "if exist `"$dotfilesDir`" git -C `"$dotfilesDir`" pull --ff-only"

  "echo Updating after-effects-mcp..."
  "if exist `"$aeMcpDir`" git -C `"$aeMcpDir`" pull --ff-only"
  "if exist `"$aeMcpDir`" pushd `"$aeMcpDir`""
  "if exist `"$aeMcpDir`" call npm install"
  "if exist `"$aeMcpDir`" call npm run build"
  "if exist `"$aeMcpDir`" popd"
)

Set-Content -Path $startupBatPath -Value ($startupBatLines -join "`r`n") -Encoding ascii
