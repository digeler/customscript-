#arm diagsonsics linux
5 $extensionName = 'LinuxDiagnostic'
6 $extensionPublisher = 'Microsoft.OSTCExtensions'
7 $extensionVersion = ‘2.3’

$config = @{"storageAccountName" = dincen ; "storageAccountKey" = ZAv2B1sFUDxNpQEmup9+OXWUOLLFR4diJMAVk2DY1Ds1PKaDr7w4wiXdCJiYsxJRqTI7J/Fn1wemjQQXflstCA=};
Set-AzureRmVMExtension -ResourceGroupName customdata -VMName vm1 -Name $extensionName -Publisher $extensionPublisher -ExtensionType $extensionName -TypeHandlerVersion $extensionVersion -ProtectedSettings $config -Location "west europe"
