function Get-Icon {
    param ([IO.FileSystemInfo]$Item)

    if ($Item.PSIsContainer) { return "📁" }

    switch ($Item.Extension.ToLower()) {
        ".txt" { "📄" }
        ".md"  { "📄" }
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
        ".7z"  { "📦" }
        ".pdf" { "📚" }
        ".doc" { "📚" }
        ".docx" { "📚" }
        default { "🥹" }
    }
}
