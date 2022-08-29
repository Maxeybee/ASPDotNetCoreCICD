Invoke-Command -ComputerName $env:COMPUTERNAME -ScriptBlock {
    $bitness = ([System.IntPtr]::size * 8) 
    Write-Output "PowerShell is $bitness-bit"
    
    [string]$path = "D:/inetpub/MyWindDashboard/MAL/"

    if(Test-Path $path){
        Write-Host "Folder MAL Exists"
        Remove-Item -Path "D:/inetpub/MyWindDashboard/MAL/" -Recurse
        
        #Rename CoreWebApp to MAL
        Rename-Item -Path "D:/inetpub/MyWindDashboard/CoreWebApp/" -NewName MAL -Force
        
        ConvertTo-WebApplication -ApplicationPool "myportalgerenewableenergy" -PSPath "IIS:/Sites/myportalgerenewableenergy/MAL" -Force
    }else{
        Write-Host "Folder MAL Not Exists"
        Rename-Item -Path "D:/inetpub/MyWindDashboard/CoreWebApp/" -NewName MAL -Force
        ConvertTo-WebApplication -ApplicationPool "myportalgerenewableenergy" -PSPath "IIS:/Sites/myportalgerenewableenergy/MAL" -Force
    }
    
}