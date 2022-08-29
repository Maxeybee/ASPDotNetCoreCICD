Invoke-Command -ComputerName $env:COMPUTERNAME -ScriptBlock {
    $bitness = ([System.IntPtr]::size * 8) 
    Write-Output "PowerShell is $bitness-bit"
    
    [string]$today = (Get-Date -Format "MM_dd_yyyy_HH_mm")
    [string]$folder = "MALCore_"
    [string]$finalFolderName = $folder+$today

    if($null -eq (Get-WebApplication 'MAL')){
        #Get-WebApplication 'CoreWebApp'
        Copy-Item -Path D:\inetpub\MyWindDashboard\CoreWebApp -Destination C:\Users\212456430\Desktop\Backup -PassThru -Recurse -Force
        Rename-Item -NewName $finalFolderName -Path C:\Users\212456430\Desktop\Backup\CoreWebApp -Force
    }else{
        #Get-WebApplication 'MAL'
        Copy-Item -Path D:\inetpub\MyWindDashboard\MAL -Destination C:\Users\212456430\Desktop\Backup -PassThru -Recurse -Force
        Rename-Item -NewName $finalFolderName -Path C:\Users\212456430\Desktop\Backup\MAL -Force
    }
}