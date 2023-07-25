$ErrorActionPreference = "Stop"

Function Create-Admin-user {
  param(
    [string]$Username,
    [string]$Password
  )

  $securePassword = ConvertTo-SecureString $Password -AsPlainText -Force

  New-LocalUser "$Username" -Password $securePassword -FullName "$Username" -Description "Temporary local admin" -PasswordNeverExpires
  Write-Verbose "$Username local user crated"
  Add-LocalGroupMember -Group "Administrators" -Member "$Username"
  Add-LocalGroupMember -Group "Remote Desktop Users" -Member "$Username"
  Write-Verbose "$Username added to the local administrator group"

  $RegistryPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
  Set-ItemProperty $RegistryPath 'AutoAdminLogon' -Value "1" -Type String
  Set-ItemProperty $RegistryPath 'DefaultUsername' -Value "$Username" -type String
  Set-ItemProperty $RegistryPath 'DefaultPassword' -Value $Password -type String

  Write-Warning "Auto-Login for $Username configured. Please restart computer."
}

Create-Admin-user -Username ${admin_user.name} -Password '${admin_user.password}'
