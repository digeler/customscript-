

$CleanupTime = [DateTime]::UtcNow.AddHours(-72)

 $con =New-AzureStorageContext -StorageAccountName dinsharevm -StorageAccountKey T3bRM5ECz2G21Ivb10nhJaAbJX
Get-AzureStorageBlob -Container "sqlbackup" -Context $con | 
Where-Object { $_.LastModified.UtcDateTime -lt $CleanupTime -and $_.BlobType -eq "PageBlob" -and $_.Name -like "*.bak"}

$CleanupTime = [DateTime]::UtcNow.AddHours(-24)
Get-AzureStorageBlob -Container "sqlbackup" -Context $context | 
Where-Object { $_.LastModified.UtcDateTime -lt $CleanupTime -and $_.BlobType -eq "PageBlob" -and $_.Name -like "*.log"} |
Remove-AzureStorageBlob




 $con =New-AzureStorageContext -StorageAccountName dinsharevm -StorageAccountKey T3bRM5ECz2G21Ivb10nhJaAbJXJ57XIC7nmqgpgIZhaky2yinktI0TlKV7vp6fzJoglOgyFzsS2czLOx5tTdmw==
$blob1 =Get-AzureStorageBlob -Container vhds -Context $con
$lockedBlobs = @()
foreach($blob in $blob1)
{
    $blobProperties = $blob.ICloudBlob.Properties
    if($blobProperties.LeaseStatus -eq "Locked")
    {
        $lockedBlobs += $blob

    }
}

if ($lockedBlobs.Count -eq 0)
    { 
        Write-Host " There are no blobs with locked lease status"
    }
if($lockedBlobs.Count -gt 0)
{
    write-host "Breaking leases"
    foreach($blob in $lockedBlobs ) 
    {
        try
        {
            $blob.AcquireLease($null, $restoreLeaseId, $null, $null, $null)
            Write-Host "The lease on $($blob.Uri) is a restore lease"
        }
        catch [Microsoft.WindowsAzure.Storage.StorageException]
        {
            if($_.Exception.RequestInformation.HttpStatusCode -eq 409)
            {
                Write-Host "The lease on $($blob.Uri) is not a restore lease"
            }
        }

        Write-Host "Breaking lease on $($blob.Uri)"
        $blob.BreakLease($(New-TimeSpan), $null, $null, $null) | Out-Null
    }
}
 