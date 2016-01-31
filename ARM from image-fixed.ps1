#Select-AzurermSubscription -SubscriptionId c93b06d0-73fb-4aba-b126-190d1ab96c8f

$ResourceGroupName = "dcstest"
$Location = "west Europe"
    
    ## Storage
    $StorageName = "dindscext "
    $StorageType = "Standard_LRS"
   
    
    ## Network
$InterfaceName = "fff-chequeprt02"
$VNetName = "dscVNET"

    
    ## Compute
    $VMName = "FFF-ChequePrt02"
    $ComputerName = "FFF-ChequePrt02"
    $VMSize = "Standard_A1"
    $OSDiskName = $VMName + "osDisk"
         
    $imageUri = "https://dindscext.blob.core.windows.net/vhds/osdisk.vhd"
    $osDiskUri = "https://dindscext.blob.core.windows.net/vhds/"+ $osDiskName +".vhd"
    


     ## Network

    $vnet =Get-AzureRmVirtualNetwork -Name $VNetName -ResourceGroupName $ResourceGroupName
        
           
    # Compute
    
    ## Setup local VM object

    $Credential = Get-Credential  

    $VirtualMachine = New-AzureRMVMConfig -VMName $VMName -VMSize $VMSize
    $VirtualMachine = set-AzureRmVMOperatingSystem -vm $VirtualMachine -windows -computername $ComputerName -Credential $Credential
       
    $Interface = New-AzureRMNetworkInterface -Name $InterfaceName -ResourceGroupName $ResourceGroupName -Location $Location -SubnetId $VNet.Subnets[0].Id
            
    $VirtualMachine = Add-AzureRMVMNetworkInterface -VM $VirtualMachine -Id $Interface.Id
      
    $VirtualMachine = Set-AzureRmVMOSDisk -VM $VirtualMachine -Name $osDiskName -VhdUri $osDiskUri -CreateOption fromImage -SourceImageUri $imageUri -windows

   
      
New-AzureRMVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $VirtualMachine -Verbose