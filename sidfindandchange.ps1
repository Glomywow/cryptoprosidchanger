[Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("windows-1251")

$objUser = New-Object System.Security.Principal.NTAccount("saw")
$strSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier])
$strSID.Value
# Путь к ветке с контейнерами

$keys_path = "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Crypto Pro\Settings\USERS\" + $strsid

Write-Host("Путь к ветке реестра: " + $keys_path)

$replace = Get-Content $export_path
$keys_array = @()
$replace = Get-Content C:\service\ps_keys.reg  -Delimiter "#" 
foreach($i in $replace){
    
    if ($i -match '^\[HKEY'){
        
      $getsid =  $i -replace '(S-1-5-21-2562163532-2550886452-409202375-61339)', "$keys_path"
    #  $getsid =  $i -replace '(?<=\[).*(?=\\Keys)', "$keys_path"

         $newreplace = Get-Content C:\service\ps_keys.reg  | ForEach-Object {$_ -replace $i , $getsid} | Set-Content C:\service\ps_keys.reg -Encoding utf8
  
        }
    else{
        Write-host("error")
    }

}

#reg import $export_path_out 

#Write-Host($keys_array)

#foreach($i in $keys_array){
    #cd  "C:\Program Files\Crypto Pro\CSP\csptest.exe"
 #   $cont =  "\\.\REGISTRY\" + $i
 #   "C:\Program Files\Crypto Pro\CSP\csptest.exe" -property -cinstall -cont $cont

 #   }
