Invoke-Command -ComputerName $env:COMPUTERNAME -ScriptBlock {
    $bitness = ([System.IntPtr]::size * 8) 
    Write-Output "PowerShell is $bitness-bit"
    if($null -eq (Get-WebApplication 'MAL')){
        Write-Host 'Get Web App CoreWebApp'
        Get-WebApplication 'CoreWebApp'
        Write-Host 'End Web App CoreWebApp'
        try {
            Remove-WebApplication -Name 'CoreWebApp' -Site 'Default Web Site'
            Write-Host 'CoreWebApp Web App Removed'
        } catch{
            Write-Host "Eror Occured" -BackgroundColor DarkRed
        }
    }else{
        Write-Host 'Get Web App MAL'
        Get-WebApplication 'MAL'
        Write-Host 'End Web App MAL'
        try {
            Remove-WebApplication -Name 'MAL' -Site 'Default Web Site'
            Write-Host 'MAL Web App Removed'
        } catch{
            Write-Host "Eror Occured" -BackgroundColor DarkRed
        }   
    }
}