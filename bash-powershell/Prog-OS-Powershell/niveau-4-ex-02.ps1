# Créez un script simple
#   1. Le signer
#   2. L’exécuter


$file = ".\test.ps1"
$certStoreLocation = "Cert:\CurrentUser\My"

# 1. créer le fichier
New-Item -Path . -Name $file -ItemType "file" -Value "Write-Output 'Hello !!'"

# 2. créer le certificat
$selfSignedCertInfo = @{
	Subject = 'greg sign script'
	Type = 'CodeSigning'
	CertStoreLocation = $certStoreLocation 
}
$cert = New-SelfSignedCertificate @selfSignedCertInfo

# 3. signer le fichier
Set-AuthenticodeSignature $file $cert

# 4. tester la signature
Get-AuthenticodeSignature -FilePath $file | Format-List *

# 5. exécuter le script
$file


# http://vcloud-lab.com/entries/powershell/How-to-sign-PowerShell-ps1-scripts




##########################################




$scriptPath = 'test.ps1'
$certStoreLocation = 'Cert:\CurrentUser\My' # This is local certification store
$certificateName = 'PSCodeCertifiate.cer'   # This is certificate to give to users

# 1. Configure script execution policy to all script must be signed
Set-ExecutionPolicy AllSigned -Force

# 2. Create a code-signing, self-signed certificate
$selfSignedCertInfo = @{
	Subject = 'greg sign script'
	Type = 'CodeSigning'
	CertStoreLocation = $certStoreLocation 
}
$cert = New-SelfSignedCertificate @selfSignedCertInfo

# 3. View the newly created certificate
Get-ChildItem -Path $certStoreLocation -CodeSigningCert | Where-Object {$_.SubjectName.Name  -Match $_.$selfSignedCertInfo.Subject}

# 4. Create a simple script
New-Item -Path . -Name $file -ItemType "file" -Value "Write-Output 'Hello !!'"

# 5. Sign the Script
$codeSignInfo = @{
	Certificate = $Cert
	FilePath = $scriptPath
}
Set-AuthenticodeSignature @codeSignInfo

# 6. Test the signature
Get-AuthenticodeSignature -FilePath $scriptPath | Format-List *

# 7. Export certificate to file on sharepath
Export-Certificate -Cert $cert -FilePath $certificateName

# 8. Import it to users trusted root certificate autorities
Import-Certificate -FilePath $certificateName -CertStoreLocation 'Cert:\CurrentUser\Root' -Confirm:$false

# 9. Import certificate to Trusted publisher store location
Import-Certificate -FilePath $certificateName -CertStoreLocation 'Cert:\CurrentUser\TrustedPublisher' -Confirm:$false

# 10. Re-sign with a trusted certificate
Set-AuthenticodeSignature @codeSignInfo

# 11. Check the script's signature
Get-AuthenticodeSignature -FilePath $scriptPath | Format-List




##########################################




New-SelfSignedCertificate -DnsName serveur_dns.domain.local -CertStoreLocation Cert:\LocalMachine\My
$certPass = ConvertTo-SecureString -String "tttttt" -Force -AsPlainText
Export-PfxCertificate -Cert Cert:\LocalMachine\My\A06F86F34776ABCFD61B2FE3C2D2EDB6D620A59B -FilePath C:\cert.pfx -Password $certPass
Export-Certificate -Cert Cert:\LocalMachine\My\A06F86F34776ABCFD61B2FE3C2D2EDB6D620A59B -FilePath C:\certpub.cer
$cert = New-SelfSignedCertificate -Subject "Certificat code powershell" -Type CodeSigningCert -CertStoreLocation Cert:\CurrentUser\My
Write-Output $cert

Set-AuthenticodeSignature -FilePath C:\script.ps1 -Certificate $cert
# appuyer ensuite sur "yes"

Get-Content script.ps1


