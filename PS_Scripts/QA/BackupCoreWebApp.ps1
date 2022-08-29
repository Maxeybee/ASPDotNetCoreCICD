Invoke-Command -ComputerName $env:COMPUTERNAME -ScriptBlock {
    $bitness = ([System.IntPtr]::size * 8) 
    Write-Output "PowerShell is $bitness-bit"
    
    [string]$today = (Get-Date -Format "MM_dd_yyyy_HH_mm")
    [string]$folder = "MALCore_"
    [string]$finalFolderName = $folder+$today

    if($null -eq (Get-WebApplication 'MAL')){
        #Get-WebApplication 'CoreWebApp'
        Copy-Item -Path D:\inetpub\wwwroot\CoreWebApp -Destination D:\inetpub\wwwroot\MalCoreBackup\ -PassThru -Recurse -Force
        Rename-Item -NewName $finalFolderName -Path D:\inetpub\wwwroot\MalCoreBackup\CoreWebApp -Force
    }else{
        #Get-WebApplication 'MAL'
        Copy-Item -Path D:\inetpub\wwwroot\MAL -Destination D:\inetpub\wwwroot\MalCoreBackup\ -PassThru -Recurse -Force
        #Copy-Item -Path D:\inetpub\wwwroot\CoreWebApp\* -Destination D:\inetpub\wwwroot\MalCoreBackup\CoreWebApp -PassThru
        Rename-Item -NewName $finalFolderName -Path D:\inetpub\wwwroot\MalCoreBackup\MAL -Force
    }
}