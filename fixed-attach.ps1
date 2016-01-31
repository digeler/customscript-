$strNewVMName = 'swigva01'
$OSDiskUri = "https://dindscext.blob.core.windows.net/vhds/osdisk.vhd"
$ResourceGroupName = "dcstest"
$VNetResourceGroupName = "dcstest"
$Location = "West Europe"

## Network
$InterfaceName = 'nic-'+$strNewVMName
$NewIpConfigNicName = 'ipco-' + $InterfaceName
$VNetName = "dscvnet"

## Compute
$VMName = $strNewVMName
$VMSize = "Standard_A1"
$OSDiskName = $VMName


# Network

$VNet = Get-AzureRMVirtualNetwork -Name $VNetName -ResourceGroupName $VNetResourceGroupName
$Interface = New-AzureRMNetworkInterface -Name $InterfaceName -ResourceGroupName $ResourceGroupName -Location $Location -SubnetId $VNet.Subnets[0].Id 

# Compute

## Setup local VM object

$VirtualMachine = New-AzureRMVMConfig -VMName $VMName -VMSize $VMSize 
$VirtualMachine = Add-AzureRMVMNetworkInterface -VM $VirtualMachine -Id $Interface.Id
$VirtualMachine = Set-AzureRMVMOSDisk -VM $VirtualMachine -Name $OSDiskName -VhdUri $OSDiskUri -CreateOption Attach -Windows
New-AzureRMVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $VirtualMachine
