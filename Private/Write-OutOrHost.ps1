function Write-OutOrHost {
    param(
        [string]$Text,
        [string]$Color
    )

    if ($Color) {
        # 使用 ANSI 颜色 + Write-Output（可重定向）
        $ansiColor = $AnsiColors[$Color]
        Write-Output "$ansiColor$Text$($AnsiColors.Reset)"
    }
    else {
        Write-Output $Text
    }
}