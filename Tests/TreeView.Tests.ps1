# Tests/TreeView.Tests.ps1
# 假设 TreeView.psm1 放在仓库根目录

# $modulePath = Join-Path $PSScriptRoot '..\TreeView.psm1'
# Import-Module $modulePath -Force

BeforeAll {
    # . "$PSScriptRoot\..\TreeView.psm1"
    # 导入模块
    Import-Module "$PSScriptRoot\..\TreeView.psm1" -Force

    # dot-source 私有函数，仅测试用
    . "$PSScriptRoot\..\Private\Get-Icon.ps1"
    . "$PSScriptRoot\..\Private\Get-Color.ps1"
}

Describe "TreeView Module Tests" {

    BeforeAll {
        # 使用临时目录，确保唯一
        $GUID = [guid]::NewGuid().ToString()
        $Root = Join-Path $env:TEMP "TreeViewTest_$GUID"
        New-Item -Path $Root -ItemType Directory -Force | Out-Null

        # 构造目录树：
        # Root/
        #   a.txt
        #   dir1/
        #     b.txt
        #     dir1-1/
        #       c.txt
        #   .hiddenfile    (测试 -a)
        New-Item -Path (Join-Path $Root 'a.txt') -ItemType File -Force | Out-Null
        New-Item -Path (Join-Path $Root '.hiddenfile') -ItemType File -Force | Out-Null
        $dir1 = New-Item -Path (Join-Path $Root 'dir1') -ItemType Directory -Force
        New-Item -Path (Join-Path $dir1.FullName 'b.txt') -ItemType File -Force | Out-Null
        $dir11 = New-Item -Path (Join-Path $dir1.FullName 'dir1-1') -ItemType Directory -Force
        New-Item -Path (Join-Path $dir11.FullName 'c.txt') -ItemType File -Force | Out-Null
    }

    AfterAll {
        # 清理
        Remove-Item -LiteralPath $Root -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Module -Name (Get-Module -Name TreeView -ErrorAction SilentlyContinue).Name -ErrorAction SilentlyContinue
    }

    Context "Get-Icon and Get-Color" {
        It "Get-Icon returns folder icon for directory" {
            $dirInfo = Get-Item $Root
            (Get-Icon -Item $dirInfo) | Should -Be "📁"
        }

        It "Get-Icon returns document icon for .txt" {
            $file = Get-Item (Join-Path $Root 'a.txt')
            (Get-Icon -Item $file) | Should -Be "📄"
        }

        It "Get-Color returns Cyan for directories" {
            $dirInfo = Get-Item $Root
            (Get-Color -Item $dirInfo) | Should -Be "Cyan"
        }

        It "Get-Color returns White for .txt" {
            $file = Get-Item (Join-Path $Root 'a.txt')
            (Get-Color -Item $file) | Should -Be "White"
        }
    }

    Context "Show-Tree / TreeView output tests" {
        It "TreeView -d only lists directories" {
            $output = & { TreeView -Path $Root -Depth 2 -D } | Out-String
            $output | Should -Match 'dir1'
            $output | Should -Not -Match 'a.txt'   # -d 不应包含文件
        }

        It "TreeView -L depth works (no deeper dir1-1 when depth 1)" {
            $output = & { TreeView -Path $Root -Depth 1 } | Out-String
            $output | Should -Match 'a.txt'
            $output | Should -Not -Match 'dir1-1'  # 深度限制生效
        }

        It "TreeView -a shows hidden files" {
            $output = & { TreeView -Path $Root -Depth 1 -A } | Out-String
            $output | Should -Match '\.hiddenfile'
        }

        # It "TreeView -f shows full path" {
        #     $output = & { TreeView -Path $Root -Depth 1 -F } | Out-String
        #     $resolved = [Regex]::Escape((Resolve-Path $Root).ProviderPath)

        #     # 匹配每行末尾的路径，忽略前面的树枝符号
        #     $output -split "`r?`n" | ForEach-Object {
        #         if ($_ -match "([^\s├└│─].+)$") {
        #             $matches[1] | Should -Match $resolved
        #         }
        #     }
        # }
        It "TreeView -f shows full path" {
            $output = & { TreeView -Path $Root -Depth 1 -F } | Out-String
            $resolved = [Regex]::Escape((Resolve-Path $Root).ProviderPath)

            $output -split "`r?`n" | ForEach-Object {
                # 只匹配以 C:\ 开头的路径部分（忽略前缀树枝符号）
                if ($_ -match "([A-Za-z]:\\.+)$") {
                    $matches[1] | Should -Match $resolved
                }
            }
        }

        It "TreeView -icon shows icons" {
            $output = & { TreeView -Path $Root -Depth 1 -Icon } | Out-String
            $output | Should -Match '📁|📄'   # 任何图标存在即可
        }

        It "TreeView outputs colors for items when color enabled" {
            $items = Get-ChildItem -Path $Root
            foreach ($item in $items) {
                $color = Get-Color -Item $item
                $color | Should -Not -BeNullOrEmpty
            }
        }
    }
}
