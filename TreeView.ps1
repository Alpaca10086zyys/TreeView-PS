param(
    [string]$Path,
    [Alias("L")][int]$Depth,    # -Depth 改名为 -L
    [switch]$icon,
    [switch]$a,                 # 是否显示隐藏文件，与 tree 的 -a 对齐
    [switch]$f,                 # 显示完整路径
    [switch]$d,                 # 只显示目录
    [switch]$C                  # 是否彩色输出
)

# 设置输出编码
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

if (-not $Path) { $Path = "." }
if (-not $Depth) { $Depth = 1 }  # 默认 depth = 1，与 tree -L 1 一致

# 颜色配置
$ColorDir = "Cyan"
$ColorFile = "White"
$ColorExe = "Yellow"
$ColorMedia = "Magenta"
$ColorArchive = "Green"
$ColorDoc = "DarkYellow"

function Get-Icon {
    param ([IO.FileSystemInfo]$Item)

    if ($Item.PSIsContainer) { return "📁" }

    $ext = $Item.Extension.ToLower()

    switch ($ext) {
        ".txt" { "📄" }
        ".md" { "📄" }
        ".json" { "📄" }
        ".xml" { "📄" }

        ".exe" { "🧱" }
        ".dll" { "🧱" }
        ".bin" { "🧱" }

        ".mp3" { "🎵" }
        ".wav" { "🎵" }

        ".mp4" { "🎬" }
        ".mov" { "🎬" }
        ".avi" { "🎬" }

        ".jpg" { "🖼️" }
        ".jpeg" { "🖼️" }
        ".png" { "🖼️" }
        ".gif" { "🖼️" }

        ".zip" { "📦" }
        ".rar" { "📦" }
        ".7z" { "📦" }

        ".pdf" { "📚" }
        ".doc" { "📚" }
        ".docx" { "📚" }

        default { "📄" }
    }
}

function Get-Color {
    param ([IO.FileSystemInfo]$Item)

    if ($Item.PSIsContainer) { return $ColorDir }

    $ext = $Item.Extension.ToLower()
    switch ($ext) {
        ".exe" { return $ColorExe }
        ".dll" { return $ColorExe }
        ".bin" { return $ColorExe }

        ".mp3" { return $ColorMedia }
        ".wav" { return $ColorMedia }

        ".mp4" { return $ColorMedia }
        ".mov" { return $ColorMedia }
        ".avi" { return $ColorMedia }

        ".zip" { return $ColorArchive }
        ".rar" { return $ColorArchive }
        ".7z" { return $ColorArchive }

        ".pdf" { return $ColorDoc }
        ".doc" { return $ColorDoc }
        ".docx" { return $ColorDoc }

        default { return $ColorFile }
    }
}

function Write-OutOrHost {
    param(
        [string]$Text,
        [string]$Color
    )

    if ($C) {
        if ($Color) {
            Write-Host $Text -ForegroundColor $Color
        } else {
            Write-Host $Text
        }
    } else {
        Write-Output $Text
    }
}


function Show-Tree {
    param (
        [string]$Dir,
        [string]$Prefix = "",
        [int]$Level = 1,   # 第一层表示 -L 1
        [switch]$icon,
        [switch]$a,
        [switch]$f,
        [switch]$d
    )

    if ($Level -gt $Depth) { return }

    # 是否显示隐藏文件
    if ($a) {
        $items = Get-ChildItem $Dir -Force
    } else {
        $items = Get-ChildItem $Dir
    }

    if ($d) { $items = $items | Where-Object { $_.PSIsContainer } }  # 只显示目录

    for ($i=0; $i -lt $items.Count; $i++) {
        $item = $items[$i]
        $isLast = ($i -eq $items.Count - 1)
        $symbol = if ($isLast) { "└── " } else { "├── " }

        $displayName = if ($f) { $item.FullName } else { $item.Name }

        $color = Get-Color -Item $item

        if ($icon) {
            $iconChar = Get-Icon -Item $item
            if ($C) {
                Write-OutOrHost "$Prefix$symbol$iconChar $displayName" $color
            } else {
                Write-OutOrHost "$Prefix$symbol$iconChar $displayName"
            }
        } else {
            if ($C) {
                Write-OutOrHost "$Prefix$symbol$displayName" $color
            } else {
                Write-OutOrHost "$Prefix$symbol$displayName"
            }
        }


        if ($item.PSIsContainer) {
            $childPrefix = if ($isLast) { "$Prefix    " } else { "$Prefix│   " }
            Show-Tree -Dir $item.FullName -Prefix $childPrefix -Level ($Level + 1) -a:$a -f:$f -d:$d -icon:$icon
        }
    }
}

# 输出根目录（与 Linux tree 行为一致）
if ($C) {
    Write-OutOrHost (Resolve-Path $Path) $ColorDir
} else {
    Write-OutOrHost (Resolve-Path $Path)
}


# 执行
Show-Tree -Dir (Resolve-Path $Path) -icon:$icon -a:$a -f:$f -d:$d -C:$C
