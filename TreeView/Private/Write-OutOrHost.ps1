# function Write-OutOrHost {
#     param(
#         [string]$Text,
#         [string]$Color
#     )

#     if ($Color) {
#         # 使用 ANSI 颜色 + Write-Output（可重定向）
#         $ansiColor = $AnsiColors[$Color]
#         Write-Output "$ansiColor$Text$($AnsiColors.Reset)"
#     }
#     else {
#         Write-Output $Text
#     }
# }

function Write-OutOrHost {
    param(
        [string]$Text,
        [string]$Color
    )

    # 如果有颜色
    if ($Color) {
        if ($script:AnsiColors.ContainsKey($Color)) {
            $ansi = $script:AnsiColors[$Color]
            $reset = $script:AnsiColors["Reset"]
            Write-Output "$ansi$Text$reset"
        }
        else {
            # 如果颜色不存在，降级为无色
            Write-Output $Text
        }
    }
    else {
        Write-Output $Text
    }
}
