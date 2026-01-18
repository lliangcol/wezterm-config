param(
  [string]$Distro = "Ubuntu",
  [int]$ListenPort = 2222,
  [int]$TargetPort = 22,
  [string]$ListenAddress = "127.0.0.1"
)

$ErrorActionPreference = "Stop"

$wslIp = (wsl -d $Distro -e sh -lc "hostname -I | awk '{print \$1}'").Trim()
if (-not $wslIp) {
  throw "Failed to detect WSL IP for distro: $Distro"
}

& netsh interface portproxy delete v4tov4 listenaddress=$ListenAddress listenport=$ListenPort | Out-Null
& netsh interface portproxy add v4tov4 listenaddress=$ListenAddress listenport=$ListenPort connectaddress=$wslIp connectport=$TargetPort | Out-Null

$ruleName = "WSL SSH $ListenPort"
$ruleExists = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue
if (-not $ruleExists) {
  New-NetFirewallRule -DisplayName $ruleName -Direction Inbound -Action Allow -Protocol TCP -LocalPort $ListenPort | Out-Null
}

Write-Host "Portproxy updated: $ListenAddress:$ListenPort -> $wslIp:$TargetPort (Distro: $Distro)"
