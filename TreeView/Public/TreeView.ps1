function TreeView {
    [CmdletBinding()]
    param(
        [string]$Path = ".",
        [Alias("L")][int]$Depth = 1,
        [switch]$icon,
        [switch]$a,
        [switch]$f,
        [switch]$d,
        [switch]$C
    )

    # 判断终端是否支持 Unicode 树形符号
    $useUnicode = Test-TerminalUnicodeSupport

    if (-not $useUnicode) {
        Write-OutOrHost "[*] Unicode 树形符号未启用，已自动切换为 ASCII 样式。" -ForegroundColor Yellow
        Write-OutOrHost "    如果启用 UTF-8 编码，可获得更美观的输出。"
        Write-OutOrHost "    请尝试：[Console]::OutputEncoding = [System.Text.Encoding]::UTF8"
    }

    $resolved = Resolve-Path $Path
    $color = if ($C) { "Cyan" } else { "" }

    Write-OutOrHost $resolved $color

    Show-Tree -Dir $resolved -MaxDepth $Depth -Icon:$icon `
        -ShowAll:$a -FullPath:$f -DirOnly:$d -Color:$C
}

Set-Alias -Name tr -Value TreeView
