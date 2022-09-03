# Get Current User
$current_user_reg = "Registry::HKEY_CURRENT_USER\SOFTWARE\Valve\Steam"
$current_user = Get-ItemProperty -Path $current_user_reg | Select-Object -ExpandProperty AutoLoginUser
gum.exe style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Current user $(gum style --foreground 212 $current_user)."

# Get Registered Users
$steam_path_reg = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Valve\Steam"
$steam_path = Get-ItemProperty -Path $steam_path_reg | Select-Object -ExpandProperty InstallPath
$users = Get-Content $steam_path"\config\loginusers.vdf" | Select-String AccountName | ForEach-Object {
  $_.ToString().Replace('"AccountName"', '').Trim().Trim('"')
}
$new_login = "[New login]"
$users += $new_login

# Set Current User
Write-Output "Switch to: "
$current_user = gum.exe choose $users | Select-Object -Skip 1
if ($current_user -ne "") {
  if ($current_user -eq $new_login) {
    $current_user = ""
  }
  
  $silent = taskkill.exe /F /IM "steam.exe"
  Set-ItemProperty -Path $current_user_reg -Name AutoLoginUser -Value $current_user
  Start-Process -FilePath $steam_path"\steam.exe"
}