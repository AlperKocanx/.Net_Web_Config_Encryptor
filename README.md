# .Net_Web_Config_Encryptor
.Net uygulamalarınızda bulunan web.config dosyalarınızın connectionStrings alanını şifrelemek için kullanabileceğiniz bir dizi açıklama içerir.

Uygulamalarınızın web.config dosyalarında bulunan connectionString alanlarını encrypt ederek açıkta duran kullanıcı adı ve şifrelerinizi saklamanızı sağlar.

.Net'in yerleşik  ASP.NET IIS Registration Tool uygulamasını kullanarak web.config dosyanızı şifreleyebilirsiniz. Bu şifreleme sonucu connectionStrings alanı insan tarafından okunamaz fakat IIS uygulamanızı deploy ettiğinde, uygulamanızın ihtiyacı olan connectionString'leri uygulamanıza sağlar.



> [!WARNING]
> ÖNEMLİ NOT: Sunucuda bu işlemleri yapmadan önce kendi bilgisayarınıza web.config dosyasını kopyalayarak saklamanız önerilir.

# İŞLEMLER

## 1- Sunucuda RSA Anahtarı Oluşturma

Sunucunuzda CMD uygulamasını yönetici olarak çalıştırınız ve şu kodu yapıştırınız:

C:\Windows\Microsoft.NET\Framework\v4.0.30319\aspnet_regiis.exe -pc "NetFrameworkConfigurationKey" -exp

Bu komut "_NetFrameworkConfigurationKey_" adında bir RSA anahtarı oluşturarak IIS'e kaydedecektir.

> [!IMPORTANT]
> C:\Windows\Microsoft.NET\Framework\v4.0.30319\aspnet_regiis.exe yolu .NET sürümünüze göre değişebilir, eğer kod çalışmazsa doğru yolu girdiğinizden emin olunuz.

> [!NOTE]
> -exp komutu anahtarı istediğinizde dışarıya (başka bir sunucuya) çıkartabilmenizi sağlar. Bu sayede aynı şifreli web.config dosyası ile başka sunucuda çalışabilirsiniz.

Şu çıktıyı almalısınız: 

![resim](https://github.com/user-attachments/assets/c42b1a89-a871-4e58-86ce-a6f2b8842e27)


## 2- IIS Application Pool İzinlerini Ayarlama

Oluşturduğunuz RSA anahtarı için IIS uygulama havuzunuzdaki (Pool) uygulamaların erişebilmesi için izin vermelisiniz.

Bunun için ekteki PowerShell komutunu (_grant_rsa_permissions.ps1_) yönetici yetkileri ile çalıştırınız. Bu işlem IIS'te bulunan tüm uygulamalara ilgili anahtara erişim için izin verecektir.


## 3- web.config Dosyasını Şifreleme


Ekte bulunan .bat dosyasını, web.config dosyanızın bulunduğu uygulama dizininize kaydederek "çift tıklayarak" çalıştırınız. Çift tıkladığınız zaman çalıştığı klasörü görebiliyor, sağ tıklarsanız hata ile karşılaşabilirsiniz.

Başarılı olursanız aşağıdaki çıktıyı görmelisiniz:

![resim](https://github.com/user-attachments/assets/de55e70d-49d3-46a2-b915-36990697d5f3)

> [!IMPORTANT]
> İşlemler başarılı olduysa IIS'ten uygulamanızı yeniden başlatmalısınız.

## 4- Son Kontroller

web.config dosyanızı açtığınızda connectionStrings içerisinde şu yapıyı gördüğünüzde işlem tamamlanmış demektir:

![resim](https://github.com/user-attachments/assets/06a0c21d-2071-406b-aa87-e7f7f669f4e3)

Sonrasında uygulamanızı çalıştırarak bağlantılarda sorun olup olmadığını test edebilirsiniz.

## 5- Şifreyi Çözme (Opsiyonel)

Eğer bir şekilde ana web.config dosyanızı kaybettiniz ve mevcut web.config dosyasının şifresini çözmek istiyorsanız aşağıdaki komutu yine yönetici hakları ile açtığınız CMD ekranında çalıştırabilirsiniz:

_C:\Windows\Microsoft.NET\Framework\v4.0.30319\aspnet_regiis.exe -pdf "connectionStrings" "C:\Yol\UygulamaDizini"_

> [!WARNING]
> Sunucunuzda oluşturduğunuz "NetFrameworkConfigurationKey" isimli anahtar dosyasını silerseniz bu RSA anahtarı ile şifrelenen config dosyaları geri döndürülemez, bu konuya dikkat etmelisiniz.


*İşinize yaradıysa yıldızlarsanız sevinirim :)*

İyi çalışmalar.
