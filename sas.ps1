# Get Current User
$current_user_reg = "Registry::HKEY_CURRENT_USER\SOFTWARE\Valve\Steam"
$current_user = Get-ItemProperty -Path $current_user_reg | Select-Object -ExpandProperty AutoLoginUser

Set-ItemProperty -Path $current_user_reg -Name AutoLoginUser -Value topazsoroako

$current_user = Get-ItemProperty -Path $current_user_reg | Select-Object -ExpandProperty AutoLoginUser
Write-Output $current_user