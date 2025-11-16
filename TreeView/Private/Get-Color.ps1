function Get-Color {
    param ([IO.FileSystemInfo]$Item)

    if ($Item.PSIsContainer) { return "Cyan" }

    $ext = $Item.Extension.ToLower()
    switch ($ext) {
        ".exe" { "Yellow" }
        ".dll" { "Yellow" }
        ".bin" { "Yellow" }
        ".mp3" { "Magenta" }
        ".wav" { "Magenta" }
        ".mp4" { "Magenta" }
        ".mov" { "Magenta" }
        ".avi" { "Magenta" }
        ".zip" { "Green" }
        ".rar" { "Green" }
        ".7z" { "Green" }
        ".pdf" { "DarkYellow" }
        ".doc" { "DarkYellow" }
        ".docx" { "DarkYellow" }
        default { "White" }
    }
}