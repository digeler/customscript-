$rgName="baracuda22"
$locName="West Europe"
$saName = "barcudadinord22"
$VMName = "dinbaracuda3"
$VMSize  = "Standard_A3"
$vnetName ="bvnet"

New-AzureRmResourceGroup -Name $rgName -Location $locName



$frontendSubnet=New-AzureRmVirtualNetworkSubnetConfig -Name frontendSubnet -AddressPrefix 10.0.1.0/24
$backendSubnet=New-AzureRmVirtualNetworkSubnetConfig -Name backendSubnet -AddressPrefix 10.0.2.0/24
New-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $rgName -Location $locName -AddressPrefix 10.0.0.0/16 -Subnet $frontendSubnet,$backendSubnet

$subnetIndex=0
$backsubnetIndex=1
$vnet=Get-AzureRMVirtualNetwork -Name $vnetName -ResourceGroupName $rgName

$nicName="nic1"
$pip=New-AzureRmPublicIpAddress -Name $nicName -ResourceGroupName $rgName -Location $locName -AllocationMethod Dynamic
$nic1=New-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName -Location $locName -SubnetId $vnet.Subnets[$subnetIndex].Id -PublicIpAddressId $pip.Id

$nicName1="nic2"
$nic2=New-AzureRmNetworkInterface -Name $nicName1 -ResourceGroupName $rgName -Location $locName -SubnetId $vnet.Subnets[$backsubnetIndex].Id

$saType="Standard_LRS" 
$storageAcc = New-AzureRmStorageAccount -Name $saName -ResourceGroupName $rgName –Type $saType -Location $locName

 
# Specify the image and local administrator account, and then add the NIC
$pubName="barracudanetworks"
#$offerName="Barracuda NextGen Firewall F-Series (BYOL)"
$offerName="barracuda-ng-firewall"
$skuName="byol"
$cred=Get-Credential -Message "dinor"
$vm = New-AzureRMVMConfig -VMName $VMName -VMSize $VMSize 
$vm=Set-AzureRmVMOperatingSystem -VM $vm -linux -ComputerName $vmName -Credential $cred # -ProvisionVMAgent -EnableAutoUpdate
$vm=Set-AzureRmVMSourceImage -VM $vm -PublisherName $pubName -Offer $offerName -Skus $skuName -Version "latest"
$vm=Add-AzureRmVMNetworkInterface -VM $vm -Id $nic1.Id -Primary
$vm=Add-AzureRmVMNetworkInterface -VM $vm -Id $nic2.Id
$vm.Plan = New-Object -TypeName 'Microsoft.Azure.Management.Compute.Models.Plan' 
#$vm.Plan.Name = 'barracuda-ng-firewall'
$vm.Plan.Name = 'byol'
$vm.Plan.Product = 'barracuda-ng-firewall'
$vm.Plan.Publisher = 'barracudanetworks' 
 
 
# Specify the OS disk name and create the VM
$diskName="baracudadisk2"
$storageAcc=Get-AzureRmStorageAccount -ResourceGroupName $rgName -Name $saName
$osDiskUri=$storageAcc.PrimaryEndpoints.Blob.ToString() + "vhds/" + $vmName + $diskName  + ".vhd"
$vm=Set-AzureRmVMOSDisk -VM $vm -Name $diskName -VhdUri $osDiskUri -CreateOption fromImage
New-AzureRmVM -ResourceGroupName $rgName -Location $locName -VM $vm
