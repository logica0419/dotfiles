Write-Host "Deploying WSL host configuration`n"

if (-not $env:USERPROFILE) {
  throw "USERPROFILE is not set. Cannot deploy .wslconfig."
}
$wslConfigUrl = "https://raw.githubusercontent.com/logica0419/dotfiles/main/windows/files/wslconfig"
$wslConfigDestination = Join-Path $env:USERPROFILE ".wslconfig"

Invoke-WebRequest -Uri $wslConfigUrl -OutFile $wslConfigDestination

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
  "9P1XD8ZQJ7JD" # Fre:ac
)

foreach ($package in $machine_packages) {
  Write-Host "Installing $package"
  winget install $package --scope machine --accept-package-agreements --accept-source-agreements
}

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
)

foreach ($package in $user_packages) {
  Write-Host "Installing $package"
  winget install $package --scope user --accept-package-agreements --accept-source-agreements
}

Write-Host "`nSetting up an auto-upgrade script`n"

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
)

Set-Content -Path $startupBatPath -Value ($startupBatLines -join "`r`n") -Encoding ascii
