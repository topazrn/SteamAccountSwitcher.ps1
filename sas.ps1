# Get Current User
$current_user_reg = "Registry::HKEY_CURRENT_USER\SOFTWARE\Valve\Steam"
$current_user = Get-ItemProperty -Path $current_user_reg | Select-Object -ExpandProperty AutoLoginUser

# List Registered Users
$steam_path_reg = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Valve\Steam"
$steam_path = Get-ItemProperty -Path $steam_path_reg | Select-Object -ExpandProperty InstallPath
Write-Output "Account list:"
"    " + $current_user + " [Active]"
Get-Content $steam_path"\config\loginusers.vdf" | Select-String AccountName | ForEach-Object {
  $test = $_.ToString().Replace('"AccountName"', '').Trim().Trim('"')
  if ($test -ne $current_user) {
    "    " + $test
  }
}

# Set Current User
$current_user = Read-Host -Prompt "Switch to account"
$silent = taskkill.exe /F /IM "steam.exe"
Set-ItemProperty -Path $current_user_reg -Name AutoLoginUser -Value $current_user
Start-Process -FilePath $steam_path"\steam.exe"