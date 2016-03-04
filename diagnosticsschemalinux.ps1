
$vm = get-azurevm -ServiceName dincentostest -Name dincentostest

$ExtensionName = 'LinuxDiagnostic'
$Publisher = 'Microsoft.OSTCExtensions'
$Version = '2.*'

$PublicConf = '{
  "perfCfg":[
    {
     "query":"SELECT BytesTotal ,TotalTxErrors FROM SCX_EthernetPortStatistics","table":"LinuxNetwork"
    }
    ],
  
  "EnableSyslog":"true"
}'

$PrivateConf = '{
    "storageAccountName": "dincen",
    "storageAccountKey": "ZAv2B1sFUDxNpQEmup9+OXWUOLLFR4diJMAVk2DY1Ds1PKaDr7w4wiXdCJiYsxJRqTI7J/Fn1wemjQQXflstCA=="
}'

Set-AzureVMExtension -ExtensionName $ExtensionName -VM $vm `
  -Publisher $Publisher -Version $Version `
  -PrivateConfiguration $PrivateConf -PublicConfiguration $PublicConf |
  Update-AzureVM