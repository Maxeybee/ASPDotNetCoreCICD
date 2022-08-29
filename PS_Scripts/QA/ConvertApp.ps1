Invoke-Command -ComputerName $env:COMPUTERNAME -ScriptBlock {
    $bitness = ([System.IntPtr]::size * 8) 
    Write-Output "PowerShell is $bitness-bit"
    
    [string]$path = "D:/inetpub/wwwroot/MAL/"

    if(Test-Path $path){
        Write-Host "Folder MAL Exists"
        Remove-Item -Path "D:/inetpub/wwwroot/MAL/" -Recurse
        Rename-Item -Path "D:/inetpub/wwwroot/CoreWebApp/" -NewName MAL -Force
        ConvertTo-WebApplication -ApplicationPool "CoreApps" -PSPath "IIS:/Sites/Default Web Site/MAL" -Force
    }else{
        Write-Host "Folder MAL Not Exists"
        Rename-Item -Path "D:/inetpub/wwwroot/CoreWebApp/" -NewName MAL -Force
        ConvertTo-WebApplication -ApplicationPool "CoreApps" -PSPath "IIS:/Sites/Default Web Site/MAL" -Force
    }
    
}