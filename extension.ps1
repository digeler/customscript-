﻿
$config = "PFdhZENmZz4NCiAgICAgICAgPERpYWdub3N0aWNNb25pdG9yQ29uZmlndXJhdGlvbiBvdmVyYWxsUXVvdGFJbk1CPSIyNTAwMCI+DQogICAgICAgIDxQZXJmb3JtYW5jZUNvdW50ZXJzIHNjaGVkdWxlZFRyYW5zZmVyUGVyaW9kPSJQVDFNIj4NCiAgICAgICAgICAgIDxQZXJmb3JtYW5jZUNvdW50ZXJDb25maWd1cmF0aW9uIGNvdW50ZXJTcGVjaWZpZXI9IlxQcm9jZXNzb3IoX1RvdGFsKVwlIFByb2Nlc3NvciBUaW1lIiBzYW1wbGVSYXRlPSJQVDFNIiB1bml0PSJwZXJjZW50IiAvPg0KICAgICAgICAgICAgPFBlcmZvcm1hbmNlQ291bnRlckNvbmZpZ3VyYXRpb24gY291bnRlclNwZWNpZmllcj0iXE1lbW9yeVxDb21taXR0ZWQgQnl0ZXMiIHNhbXBsZVJhdGU9IlBUMU0iIHVuaXQ9ImJ5dGVzIi8+DQogICAgICAgICAgICA8L1BlcmZvcm1hbmNlQ291bnRlcnM+DQogICAgICAgICAgICA8RXR3UHJvdmlkZXJzPg0KICAgICAgICAgICAgICAgIDxFdHdFdmVudFNvdXJjZVByb3ZpZGVyQ29uZmlndXJhdGlvbiBwcm92aWRlcj0iU2FtcGxlRXZlbnRTb3VyY2VXcml0ZXIiIHNjaGVkdWxlZFRyYW5zZmVyUGVyaW9kPSJQVDVNIj4NCiAgICAgICAgICAgICAgICAgICAgPEV2ZW50IGlkPSIxIiBldmVudERlc3RpbmF0aW9uPSJFbnVtc1RhYmxlIi8+DQogICAgICAgICAgICAgICAgICAgIDxFdmVudCBpZD0iMiIgZXZlbnREZXN0aW5hdGlvbj0iTWVzc2FnZVRhYmxlIi8+DQogICAgICAgICAgICAgICAgICAgIDxFdmVudCBpZD0iMyIgZXZlbnREZXN0aW5hdGlvbj0iU2V0T3RoZXJUYWJsZSIvPg0KICAgICAgICAgICAgICAgICAgICA8RXZlbnQgaWQ9IjQiIGV2ZW50RGVzdGluYXRpb249IkhpZ2hGcmVxVGFibGUiLz4NCiAgICAgICAgICAgICAgICAgICAgPERlZmF1bHRFdmVudHMgZXZlbnREZXN0aW5hdGlvbj0iRGVmYXVsdFRhYmxlIiAvPg0KICAgICAgICAgICAgICAgIDwvRXR3RXZlbnRTb3VyY2VQcm92aWRlckNvbmZpZ3VyYXRpb24+DQogICAgICAgICAgICA8L0V0d1Byb3ZpZGVycz4NCiAgICAgICAgPC9EaWFnbm9zdGljTW9uaXRvckNvbmZpZ3VyYXRpb24+DQogICAgPC9XYWRDZmc+"
$settings = @{ "xmlCfg" = $config ; "storageAccount" = "dinwad" };
$StorageAccountKey = "W0vDMcQHRqNESIosR+fZhAxrig2yB480YxgpJAron+CV5Io7ImHLgNZHvOq3Yg4nj0piYkCXpmcX2Q1a/4TrkQ=="
$ProtectedSettings = @{ "storageAccountName" = "dinwad" ; "storageAccountKey" = $StorageAccountKey; "storageAccountEndPoint" = "https://core.windows.net/" };
Set-AzureVMExtension -ResourceGroupName "dinlbtest" -VMName "dinnlb0" -Location "west europe" -Name "Microsoft.Insights.VMDiagnosticsSettings" -Publisher "Microsoft.Azure.Diagnostics" -ExtensionType "IaaSDiagnostics" -TypeHandlerVersion "1.2" -Settings $Settings -ProtectedSettings $ProtectedSettings