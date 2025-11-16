# . $PSScriptRoot\Test-Terminal.ps1
# . $PSScriptRoot\Symbols.ps1

function Show-Tree {
    param(
        [string]$Dir,
        [string]$Prefix = "",
        [int]$Level = 1,
        [int]$MaxDepth = 1,
        [switch]$Icon,
        [switch]$ShowAll,
        [switch]$FullPath,
        [switch]$DirOnly,
        [switch]$Color
    )

    if ($Level -gt $MaxDepth) { return }

    # 自动选择符号：支持 Unicode → Unicode，否则 ASCII
    $Symbols = if (Test-TerminalUnicodeSupport) {
        $TreeSymbolsUnicode
    } else {
        $TreeSymbolsAscii
    }

    $items = Get-ChildItem $Dir -Force:$ShowAll
    if ($DirOnly) { $items = $items | Where-Object PSIsContainer }

    for ($i=0; $i -lt $items.Count; $i++) {

        $item = $items[$i]
        $isLast = ($i -eq $items.Count - 1)
        $symbol = if ($isLast) { $Symbols.Last } else { $Symbols.Branch }

        $display = if ($FullPath) { $item.FullName } else { $item.Name }
        $colorName = Get-Color $item

        # 输出内容
        if ($Icon) {
            $iconChar = Get-Icon $item
            Write-OutOrHost "$Prefix$symbol$iconChar $display" ($(if ($Color) { $colorName } else { "" }))
        }
        else {
            Write-OutOrHost "$Prefix$symbol$display" ($(if ($Color) { $colorName } else { "" }))
        }

        if ($item.PSIsContainer) {
            $nextPrefix = if ($isLast) { "$Prefix    " } else { "$Prefix│   " }
            Show-Tree -Dir $item.FullName -Prefix $nextPrefix -Level ($Level+1) -MaxDepth $MaxDepth `
                -Icon:$Icon -ShowAll:$ShowAll -FullPath:$FullPath -DirOnly:$DirOnly -Color:$Color
        }
    }
}