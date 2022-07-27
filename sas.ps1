# $steam_path_reg = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Valve\Steam"
# $steam_path = Get-ItemProperty -Path $steam_path_reg | Select-Object -ExpandProperty InstallPath

# Get-Content $steam_path"\config\loginusers.vdf"

$current_user_reg = "Registry::HKEY_CURRENT_USER\SOFTWARE\Valve\Steam"
$current_user = Get-ItemProperty -Path $current_user_reg | Select-Object -ExpandProperty AutoLoginUser
Write-Output $current_user

Set-ItemProperty -Path $current_user_reg -Name AutoLoginUser -Value topazsoroako

$current_user = Get-ItemProperty -Path $current_user_reg | Select-Object -ExpandProperty AutoLoginUser
Write-Output $current_user