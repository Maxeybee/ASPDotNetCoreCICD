Invoke-Command -ComputerName $env:COMPUTERNAME -ScriptBlock {
    $bitness = ([System.IntPtr]::size * 8) 
    Write-Output "PowerShell is $bitness-bit"
    
    if($null -eq (Get-WebApplication 'MAL')){
        # if MAL does not exist
        try {
            Remove-WebApplication -Name 'CoreWebApp' -Site 'myportalgerenewableenergy'
            Write-Host 'CoreWebApp Web App Removed'
        } catch{
            Write-Host "Eror Occured" -BackgroundColor DarkRed
        }
    }else{
        # if MAL exists
        try {
            Remove-WebApplication -Name 'MAL' -Site 'myportalgerenewableenergy'
            Write-Host 'MAL Web App Removed'
        } catch{
            Write-Host "Eror Occured" -BackgroundColor DarkRed
        }   
    }
}