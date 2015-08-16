 Select-AzureSubscription -SubscriptionId 928f4e7e-2c28-4063-a56e-6f1e6f2bb73c -Current
$ResourceGroupName = "prem"
    $Location = "westeurope"
    
    ## Storage
    $StorageName = "premstoraged"
    $StorageType = "PremiumLRS"
    $StorageAccount = "premstoraged"
    
    ## Network
    $InterfaceName = "Mypremnic"
    $Subnet1Name = "Subnet"
    $VNetName = "MyVNET"
    $VNetAddressPrefix = "10.0.0.0/16"
    $VNetSubnetAddressPrefix = "10.0.0.0/24"
    
    ## Compute
    $VMName = "myimagedinvm"
    $ComputerName = "testserver"
    $VMSize = "Standard_DS14"
    $OSDiskName = $VMName + "osDisk"
    
    
    
    # Network
    $PIp = New-AzurePublicIpAddress -Name $InterfaceName -ResourceGroupName $ResourceGroupName -Location $Location -AllocationMethod Dynamic
    $SubnetConfig = New-AzureVirtualNetworkSubnetConfig -Name $Subnet1Name -AddressPrefix $VNetSubnetAddressPrefix
    $VNet = New-AzureVirtualNetwork -Name $VNetName -ResourceGroupName $ResourceGroupName -Location $Location -AddressPrefix $VNetAddressPrefix -Subnet $SubnetConfig
    
   
    # Compute
    
    ## Setup local VM object
    $Credential = Get-Credential
    $VirtualMachine = New-AzureVMConfig -VMName $VMName -VMSize $VMSize
   
    $VirtualMachine = Set-AzureVMOSDisk -VhdUri "https://premstoraged.blob.core.windows.net/vhds/clone.vhd" -vm $VirtualMachine -Name myvm -CreateOption attach
    
   
    $VirtualMachine = Add-AzureVMNetworkInterface -VM $VirtualMachine -Id $Interface.Id

    $VirtualMachine.StorageProfile.OSDisk.OperatingSystemType = "Windows"
   
    
    
    
    ## Create the VM in Azur



   New-AzureVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $VirtualMachine 

