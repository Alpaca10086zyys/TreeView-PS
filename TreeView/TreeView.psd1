@{
    RootModule        = 'TreeView.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = 'b3359b17-0a90-4f4f-8dfd-cbdd61ed9d51'
    Author            = 'Yue Zhang'
    CompanyName       = 'Unknown'
    Copyright         = '(c) 2025 ZhangYue. All rights reserved.'
    Description       = 'A Tree View command with icons and colors'
    FunctionsToExport = @('TreeView')
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()
    PowerShellVersion = '5.1'

    PrivateData       = @{
        PSData = @{
            Tags       = @('tree', 'filesystem', 'directory', 'view', 'icon', 'color')
            LicenseUri = ''
            ProjectUri = ''
            # IconUri    = ''
        }
    }
}
