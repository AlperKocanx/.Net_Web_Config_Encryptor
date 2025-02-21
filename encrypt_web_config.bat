@echo off
echo Web.config dosyasindaki connectionStrings bolumu sifreleniyor...

:: .NET Framework yolu
set ASPNET_REGIIS_PATH=C:\Windows\Microsoft.NET\Framework\v4.0.30319\aspnet_regiis.exe

:: Geçerli dizini al
set CURRENT_DIR=%CD%

:: web.config dosyasını kontrol et
if not exist "%CURRENT_DIR%\web.config" (
    echo Hata: web.config dosyasi bulunamadi!
    pause
    exit /b 1
)

:: Varsa mevcut şifreyi çöz
echo Varsa mevcut sifreyi cozmeye calisiyor...
"%ASPNET_REGIIS_PATH%" -pdf "connectionStrings" "%CURRENT_DIR%"

:: connectionStrings bölümünü şifrele
echo Sifreleme islemi basliyor...
"%ASPNET_REGIIS_PATH%" -pef "connectionStrings" "%CURRENT_DIR%" -prov "RsaProtectedConfigurationProvider"

:: Başarı kontrolü
if %ERRORLEVEL%==0 (
    echo Basariyla sifrelendi!
) else (
    echo Hata olustu! Sifreleme basarisiz.
)

pause