# IIS WebAdministration modülünü yükle
Import-Module WebAdministration

# aspnet_regiis.exe yolu
$aspnetRegIis = "C:\Windows\Microsoft.NET\Framework\v4.0.30319\aspnet_regiis.exe"

# RSA anahtar konteyner adı
$keyContainer = "NetFrameworkConfigurationKey"

# Tüm AppPool’ları al
$appPools = Get-ChildItem IIS:\AppPools | Select-Object -ExpandProperty Name

# Her AppPool için izin ver
foreach ($appPool in $appPools) {
    $appPoolIdentity = "IIS APPPOOL\$appPool"
    Write-Host "Adding permission for $appPoolIdentity to RSA key container $keyContainer..."
    & $aspnetRegIis -pa $keyContainer $appPoolIdentity
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Successfully added permission for $appPoolIdentity."
    } else {
        Write-Host "Failed to add permission for $appPoolIdentity!"
    }
}

Write-Host "All permissions have been set!"