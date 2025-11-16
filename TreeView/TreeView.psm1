# # 模块导出函数：TreeView

# # ANSI 转义序列颜色（避免 Write-Host）
# $AnsiColors = @{
#     Cyan       = "`e[36m"
#     White      = "`e[37m"
#     Yellow     = "`e[33m"
#     Magenta    = "`e[35m"
#     Green      = "`e[32m"
#     DarkYellow = "`e[33m"
#     Reset      = "`e[0m"
# }

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

# function Get-Icon {
#     param ([IO.FileSystemInfo]$Item)

#     if ($Item.PSIsContainer) { return "📁" }

#     $ext = $Item.Extension.ToLower()
#     switch ($ext) {
#         ".txt" { "📄" }
#         ".md" { "📄" }
#         ".json" { "📄" }
#         ".xml" { "📄" }
#         ".exe" { "🧱" }
#         ".dll" { "🧱" }
#         ".bin" { "🧱" }
#         ".mp3" { "🎵" }
#         ".wav" { "🎵" }
#         ".mp4" { "🎬" }
#         ".mov" { "🎬" }
#         ".avi" { "🎬" }
#         ".jpg" { "🖼️" }
#         ".jpeg" { "🖼️" }
#         ".png" { "🖼️" }
#         ".gif" { "🖼️" }
#         ".zip" { "📦" }
#         ".rar" { "📦" }
#         ".7z" { "📦" }
#         ".pdf" { "📚" }
#         ".doc" { "📚" }
#         ".docx" { "📚" }
#         default { "📄" }
#     }
# }

# function Get-Color {
#     param ([IO.FileSystemInfo]$Item)

#     if ($Item.PSIsContainer) { return "Cyan" }

#     $ext = $Item.Extension.ToLower()
#     switch ($ext) {
#         ".exe" { "Yellow" }
#         ".dll" { "Yellow" }
#         ".bin" { "Yellow" }
#         ".mp3" { "Magenta" }
#         ".wav" { "Magenta" }
#         ".mp4" { "Magenta" }
#         ".mov" { "Magenta" }
#         ".avi" { "Magenta" }
#         ".zip" { "Green" }
#         ".rar" { "Green" }
#         ".7z" { "Green" }
#         ".pdf" { "DarkYellow" }
#         ".doc" { "DarkYellow" }
#         ".docx" { "DarkYellow" }
#         default { "White" }
#     }
# }

# function Show-Tree {
#     param(
#         [string]$Dir,
#         [string]$Prefix = "",
#         [int]$Level = 1,
#         [int]$MaxDepth = 1,
#         [switch]$Icon,
#         [switch]$ShowAll,
#         [switch]$FullPath,
#         [switch]$DirOnly,
#         [switch]$Color
#     )

#     if ($Level -gt $MaxDepth) { return }

#     $items = Get-ChildItem $Dir -Force:$ShowAll
#     if ($DirOnly) { $items = $items | Where-Object PSIsContainer }

#     for ($i=0; $i -lt $items.Count; $i++) {

#         $item = $items[$i]
#         $isLast = ($i -eq $items.Count - 1)
#         $symbol = if ($isLast) { "└── " } else { "├── " }

#         $display = if ($FullPath) { $item.FullName } else { $item.Name }
#         $colorName = Get-Color $item

#         # 输出内容
#         if ($Icon) {
#             $iconChar = Get-Icon $item
#             Write-OutOrHost "$Prefix$symbol$iconChar $display" ($(if ($Color) { $colorName } else { "" }))
#         }
#         else {
#             Write-OutOrHost "$Prefix$symbol$display" ($(if ($Color) { $colorName } else { "" }))
#         }

#         if ($item.PSIsContainer) {
#             $nextPrefix = if ($isLast) { "$Prefix    " } else { "$Prefix│   " }
#             Show-Tree -Dir $item.FullName -Prefix $nextPrefix -Level ($Level+1) -MaxDepth $MaxDepth `
#                 -Icon:$Icon -ShowAll:$ShowAll -FullPath:$FullPath -DirOnly:$DirOnly -Color:$Color
#         }
#     }
# }

# function TreeView {
#     [CmdletBinding()]
#     param(
#         [string]$Path = ".",
#         [Alias("L")][int]$Depth = 1,
#         [switch]$icon,
#         [switch]$a,
#         [switch]$f,
#         [switch]$d,
#         [switch]$C
#     )

#     $resolved = Resolve-Path $Path
#     $color = if ($C) { "Cyan" } else { "" }
#     Write-OutOrHost $resolved $color


#     Show-Tree -Dir $resolved -MaxDepth $Depth -Icon:$icon -ShowAll:$a `
#         -FullPath:$f -DirOnly:$d -Color:$C
# }

# Set-Alias -Name tr -Value TreeView
# Export-ModuleMember -Function TreeView -Alias tr

# Load Private files first (order matters)
. $PSScriptRoot\Private\AnsiColors.ps1
. $PSScriptRoot\Private\Get-Color.ps1
. $PSScriptRoot\Private\Get-Icon.ps1
. $PSScriptRoot\Private\Write-OutOrHost.ps1
. $PSScriptRoot\Private\Symbols.ps1
. $PSScriptRoot\Private\Test-Terminal.ps1
. $PSScriptRoot\Private\Show-Tree.ps1

# Load Public commands
. $PSScriptRoot\Public\TreeView.ps1

Export-ModuleMember -Function TreeView -Alias tr
