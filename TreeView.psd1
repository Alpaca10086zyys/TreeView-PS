@{

    # 与此清单关联的脚本模块或二进制模块文件。
    RootModule = 'TreeView.psm1'

    # 此模块的版本号。
    ModuleVersion = '1.0.0'

    # 支持的 PSEditions
    # CompatiblePSEditions = @()

    # 用于唯一标识此模块的 ID
    GUID = 'b3359b17-0a90-4f4f-8dfd-cbdd61ed9d51'

    # 此模块的作者
    Author = 'Yue Zhang'

    # Company or vendor of this module
    CompanyName = 'Unknown'

    # 此模块的版权声明
    Copyright = '(c) 2025 YourName。保留所有权利。'

    # 此模块所提供功能的说明
    Description = 'A Tree View command with icons and colors'

    # 要从此模块中导出的函数。为了获得最佳性能，请不要使用通配符，不要删除该条目。如果没有要导出的函数，请使用空数组。
    FunctionsToExport = @('TreeView')

    # 要从此模块中导出的 cmdlet。为了获得最佳性能，请不要使用通配符，不要删除该条目。如果没有要导出的 cmdlet，请使用空数组。
    CmdletsToExport = @()

    # 要从此模块中导出的变量
    VariablesToExport = @()

    # 要从此模块中导出的别名。为了获得最佳性能，请不要使用通配符，不要删除该条目。如果没有要导出的别名，请使用空数组。
    AliasesToExport = @()

    PowerShellVersion = '5.1'

    # 要传递到 RootModule/ModuleToProcess 中指定的模块的专用数据。这还可能包含 PSData 哈希表以及 PowerShell 使用的其他模块元数据。
    PrivateData = @{
        PSData = @{
            # 应用于此模块的标记。这些标记有助于在联机库中执行模块发现。
            Tags = @('tree', 'filesystem', 'directory', 'view', 'icon', 'color')

            # 指向此模块的许可证的 URL。
            LicenseUri = ''

            # 指向此项目的主网站的 URL。
            ProjectUri = ''

            # 指向表示此模块的图标的 URL。
            # IconUri = ''
        }

    }
}

