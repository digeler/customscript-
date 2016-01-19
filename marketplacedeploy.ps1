# Set values for existing resource group and storage account names
$rgName="baracuda"
$locName="West Europe"
$saName = "dinbar"
$VMName = "dinbaracuda"
$VMSize  = "Standard_A1"

$nic1 =Get-AzureRmNetworkInterface -Name nic1 -ResourceGroupName baracuda
$nic2 =Get-AzureRmNetworkInterface -Name nic2 -ResourceGroupName baracuda



# Specify the image and local administrator account, and then add the NIC
$pubName="BarracudaNetworks"
$offerName="Barracuda NextGen Firewall F-Series (BYOL)"
$skuName="byol"
$cred=Get-Credential -Message "demouser"
$vm = New-AzureRMVMConfig -VMName $VMName -VMSize $VMSize 
$vm=Set-AzureRmVMOperatingSystem -VM $vm -linux -ComputerName $vmName -Credential $cred # -ProvisionVMAgent -EnableAutoUpdate
$vm=Set-AzureRmVMSourceImage -VM $vm -PublisherName $pubName -Offer $offerName -Skus $skuName -Version "latest"
$vm=Add-AzureRmVMNetworkInterface -VM $vm -Id $nic1.Id -Primary
$vm=Add-AzureRmVMNetworkInterface -VM $vm -Id $nic2.Id
$vm.Plan = New-Object -TypeName 'Microsoft.Azure.Management.Compute.Models.Plan' 
$vm.Plan.Name = 'barracuda-ng-firewall'
$vm.Plan.Product = 'barracuda-ng-firewall'
$vm.Plan.Publisher = 'BarracudaNetworks' 


# Specify the OS disk name and create the VM
$diskName="baracudadisk"
$storageAcc=Get-AzureRmStorageAccount -ResourceGroupName $rgName -Name $saName
$osDiskUri=$storageAcc.PrimaryEndpoints.Blob.ToString() + "vhds/" + $vmName + $diskName  + ".vhd"
$vm=Set-AzureRmVMOSDisk -VM $vm -Name $diskName -VhdUri $osDiskUri -CreateOption fromImage
New-AzureRmVM -ResourceGroupName $rgName -Location $locName -VM $vm
